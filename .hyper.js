module.exports = {
  config: {
    fontSize: 12.5,
    fontFamily: "FiraCode Nerd Font",
    cursorColor: "rgba(255,255,255,.4)",
    foregroundColor: "rgb(131,148,150)",
    backgroundColor: "#293462",
    borderColor: "rgba(255,255,255,.1)",
    selectionColor: "#E3CCB2",
    css: `
  .term_active {
    background-color: rgb(40, 44, 52) !important;
  }
    `,
    termCSS: "",
    padding: "0px 5px",
    // some color overrides. see http://bit.ly/29k1iU2 for
    // the full list
    colors: [
      "#002834",
      "#dc322f",
      "#859901",
      "#b58901",
      "#268bd2",
      "#d33682",
      "#2aa198",
      "#eee8d5",
      "#839496",
      "#cb4b16",
      "#3d713a",
      "#83773b",
      "#839496",
      "#839496",
      "#93a1a1",
      "#93a1a1",
    ],
  },
  plugins: [
  // "hyper-solarized-light", 
  "hyper-tab-icons", 
  "hyper-firewatch"],
};
