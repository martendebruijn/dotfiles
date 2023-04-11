module.exports = {
  config: {
    fontSize: 12.5,
    fontFamily: "MesloLGS Nerd Font",
    cursorColor: "rgba(255,255,255,.4)",
    foregroundColor: "rgb(131,148,150)",
    backgroundColor: "#293462",
    borderColor: "rgba(255,255,255,.1)",
    css: `
      .header_header {
        background: transparent!important;
      }
      .tab_tab {
        border: 0;
      }
      .tab_active::before {
        border-bottom: 2px solid rgba(255,255,255,.5);
      }
      .tab_hasActivity {
        color: #42a1e4;
      }
      .tab_hasActivity:hover {
        color: #96d4e4;
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
  // format: [@org/]project[#version]
  plugins: ["hyper-solarized-light", "hyper-highlight-active-pane"],
  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
};
