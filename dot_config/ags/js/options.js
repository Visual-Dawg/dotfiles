export default {
  // if this player is running this will be shown on panel
  preferredMpris: "rhytmbox",

  // number of workspaces shown on panel and overview
  workspaces: 9,

  //
  dockItemSize: 56,

  battaryBar: {
    // wether to show percentage by deafult
    showPercentage: false,

    // at what percentages should the battery-bar change color
    low: 30,
    medium: 50,
  },

  // path to read temperature from
  temperature: "/sys/class/thermal/thermal_zone0/temp",

  // at what intervals should cpu, ram, temperature refresh
  systemFetchInterval: 5000,

  // the slide down animation on quicksettings
  windowAnimationDuration: 250,
}
