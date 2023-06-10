import {
	replaceIllegalFileNameCharacters,
	saveImage,
	selectTags,
} from "../lib/helper.cjs"
import type { QuickAddArgument } from "../Types"

module.exports = getWebsiteData

async function getWebsiteData(quickAdd: QuickAddArgument) {
	console.log("Getting website data")

	const clipboard = await quickAdd.quickAddApi.utility.getClipboard()
	const url = await quickAdd.quickAddApi.inputPrompt(
		"Enter website URL: ",
		clipboard,
		clipboard
	)
	const urlObject = new URL(url)

	const html = await quickAdd.obsidian.request(url).catch((error) => {
		console.error(error)
		throw new Error(`Failed to get website data. URL: ${url}, ${error}`)
	})
	const parser = new DOMParser()
	const dom = parser.parseFromString(html, "text/html")
	const { head } = dom
	console.log({ head })

	const defaultFavicon = urlObject.origin + "/favicon.ico"
	const smallFavion = await quickAdd.obsidian
		.request(defaultFavicon)
		.then((_) => defaultFavicon)
		.catch((_) => undefined)

	const title = head.querySelector("title")?.textContent
	const description =
		getMetaPropertyData(dom, "description") ??
		getMetaNameData(dom, "description")

	const siteName = getMetaPropertyData(dom, "og:site_name")
	const imageURL =
		getMetaPropertyData(dom, "og:image") ??
		getFaviconFromHTML(dom) ??
		smallFavion
	const fileName = replaceIllegalFileNameCharacters(
		urlObject.host.replace("www.", "") + urlObject.pathname
	)

	const imagePath =
		imageURL &&
		(await saveImage({
			url: imageURL,
			fileName,
			api: quickAdd.obsidian,
			folder: "Website_Preview",
		}))

	const tags = await selectTags(quickAdd)

	quickAdd.variables = {
		...quickAdd.variables,
		title,
		url,
		description,
		siteName,
		tags,
		image: imagePath,
		fileName: transformURLtoFilename(url),
	}
}

function getMetaPropertyData(
	dom: Document,
	property: string
): string | undefined {
	const metaData = (
		dom.querySelector(`meta[property="${property}"]`) as HTMLMetaElement
	)?.content

	console.log({ property: metaData })
	return metaData ?? undefined
}

function getMetaNameData(dom: Document, name: string): string | undefined {
	const metaData = (
		dom.querySelector(`meta[name="${name}"]`) as HTMLMetaElement
	)?.content
	console.log({ name: metaData })

	return metaData ?? undefined
}
function getFaviconFromHTML(dom: Document): string | undefined {
	const icons = [
		...dom.querySelectorAll("link[rel='icon']"),
		...dom.querySelectorAll("link[rel='icon shortcut']"),
		...dom.querySelectorAll("link[rel='apple-touch-icon']"),
		...dom.querySelectorAll("link[rel='mask-icon']"),
	] as HTMLLinkElement[]

	return getBestQualityIcon(icons)?.href
}

function getBestQualityIcon(icons: readonly HTMLLinkElement[]) {
	if (icons.length === 0) return undefined

	const svg = icons.find(
		(icon) =>
			icon.type === "image/svg+xml" ||
			icon.type === "image/svg" ||
			icon.href.replace(/(\?|\#).*/, "").endsWith(".svg")
	)

	if (svg) return svg

	return icons.reduce((best, icon) => {
		if (getIconSize(icon) > getIconSize(best)) return icon

		return best
	})
}

function getIconSize(icon: HTMLLinkElement) {
	const size = icon.sizes?.value.split("x").at(0)

	if (!size) return 0

	return Number(size)
}

function transformURLtoFilename(url: string) {
	return replaceIllegalFileNameCharacters(new URL(url).host.replace("www.", ""))
}
