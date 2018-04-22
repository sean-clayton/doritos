import chroma from "chroma-js";

const rawColors = {
  steel: "#626262",
  silver: "#B0B0B0",
  white: "#DEDEDE",
  red: "#9B3332",
  mauve: "#DB6766",
  salmon: "#EE807F",
  orange: "#DB8B00",
  coral: "#F8AE58",
  peach: "#FECB9C",
  gold: "#CCAE2C",
  yellow: "#F3BC2B",
  pale: "#FDD879",
  sage: "#57741A",
  green: "#90A560",
  olive: "#D8EFA7",
  teal: "#31787E",
  aqua: "#4ABBC1",
  cyan: "#91EDEC",
  blue: "#325992",
  cobalt: "#5588DB",
  sapphire: "#97B5F5",
  violet: "#553E8F",
  orchid: "#9175E3",
  lavender: "#C4B4FD",
  crimson: "#830147",
  ruby_wine: "#D23C83",
  pink: "#FC8BB9",
  brown: "#513714",
  tan: "#AC8A6E",
  khaki: "#E0BEA2"
};

export const palette = Object.entries(rawColors).reduce(
  (acc, [name, color]) => ({
    ...acc,
    [name]: [100, 200, 300, 400, 500, 600, 700, 800, 900].reduce(
      (a, c) => ({
        ...a,
        [c]: chroma
          .scale([
            chroma(color).set("lab.l", "*0.25"),
            color,
            chroma(color).set("lab.l", "*4")
          ])
          .mode("lab")(c / 1000)
      }),
      {}
    )
  }),
  {}
);
