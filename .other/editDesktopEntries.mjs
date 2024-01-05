#!/usr/bin/env zx

//@ts-check

import "zx/globals"

import { replaceInFile } from "./script-helpers/helper.mjs"

const platfromWayland = [
  // "/usr/share/applications/tutanota-desktop.desktop",
  "/usr/share/applications/morgen.desktop",
  "/usr/share/applications/GitKraken.desktop",
]

/** @type {{entry: string, replacers:[RegExp, (match: string)=> string][]}[]} */
const entries = [
  {
    entry: "/usr/share/applications/vencord-desktop.desktop",
    replacers: [
      launchAsWayland(),
      [createRegex("Name"), () => "Discord"],
      [createRegex("icon"), () => "discord"],
    ],
  },

  {
    entry: "/usr/share/applications/Mailspring.desktop",
    replacers: [
      [createRegex("Exec"), append('--password-store="gnome-libsecret"')],
    ],
  },

  {
    entry: "/usr/share/applications/code-oss.desktop",
    replacers: [
      [createRegex("Name"), () => "VSCode"],
      [createRegex("Icon"), () => "visual-studio-code"],
    ],
  },

  ...platfromWayland.map((entry) => ({
    entry,
    replacers: [launchAsWayland()],
  })),
]

for (const { entry, ...options } of entries) {
  replaceInFile(
    entry,
    options.replacers.map((replacer) => [replacer[0], replacer[1]])
  )

  console.log(`Edited ${entry}`)
}

/**
 * @returns  {[RegExp, (match: string) => string]} replacer
 */
function launchAsWayland() {
  const waylandFlag = "--ozone-platform=wayland"

  return [createRegex("Exec"), append(waylandFlag)]
}

/**
 * @param {string} option
 * A regex to match the value of a key in a desktop entry */
function createRegex(option) {
  return new RegExp(`(?<=^${option}=).*`, "m")
}

/** @param {string} toAppend */
function append(toAppend) {
  /** @param {string} baseString */
  return (baseString) =>
    baseString.endsWith(toAppend)
      ? baseString
      : baseString.concat(" ", toAppend)
}

/** @param {string} toPrepend*/
function prepend(toPrepend) {
  /** @param {string} baseString */
  return (baseString) =>
    baseString.startsWith(toPrepend)
      ? baseString
      : toPrepend.concat(" ", baseString)
}
