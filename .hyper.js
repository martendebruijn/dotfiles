module.exports = {
  config: {
    fontSize: 12.5,
    fontFamily: "MesloLGS NF",
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
  // Auto switch dark/light theme is not supported, see: [issue](https://github.com/vercel/hyper/issues/6305)
  // solarized-light has to be command out for it to use the correct header styling
  // prettier-ignore
  plugins: [
"hyper-solarized-light",
// "hyper-solarized-dark",
  ],
  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
};
