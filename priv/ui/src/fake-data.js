import faker from "faker";

const serviceTagAlphabet = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "0"
];

export const servers = Array(10) // 620
  .fill()
  .map(() => ({
    ip: `${faker.internet.ip()}:11775`,
    name: faker.random.words(),
    port: 11774,
    hostPlayer: faker.internet.userName(),
    sprintEnabled: faker.random.boolean(),
    sprintUnlimitedEnabled: faker.random.boolean(),
    dualWielding: faker.random.boolean(),
    assassinationEnabled: faker.random.boolean(),
    votingEnabled: faker.random.boolean(),
    teams: faker.random.boolean(),
    status: faker.random.arrayElement(["InGame", "InLobby"]),
    map: faker.random.arrayElement([
      "The Pit",
      "Guardian",
      "Diamondback",
      "Valhalla",
      "Narrows",
      "Icebox",
      "Edge",
      "Reactor"
    ]),
    passworded: faker.random.boolean(),
    mapFile: faker.lorem.word(),
    xnkid: faker.random.uuid(),
    xnaddr: faker.random.uuid(),
    variantType: faker.random.arrayElement([
      "slayer",
      "infection",
      "assault",
      "koth",
      "oddball",
      "juggernaut",
      "ctf",
      "none"
    ]),
    isDedicated: faker.random.boolean(),
    gameVersion: "1.106708_cert_ms23___release",
    eldewritoVersion: "0.6.0.0"
  }))
  .map(d => {
    const players = Array(faker.random.number({ min: 0, max: 16 }))
      .fill()
      .map(() => ({
        isAlive: Boolean(faker.random.number({ min: 0, max: 3 })),
        uid: faker.random.uuid(),
        kills: faker.random.number({ min: 0, max: 18 }),
        assists: faker.random.number({ min: 0, max: 18 }),
        deaths: faker.random.number({ min: 0, max: 18 }),
        betrayals: faker.random.number({ min: 0, max: 3 }),
        suicide: faker.random.number({ min: 0, max: 3 }),
        bestStreak: faker.random.number({ min: 0, max: 18 }),
        timeSpentAlive: faker.random.number({ min: 0, max: 1000 }),
        primaryColor: `#${faker.random
          .number({ min: 0, max: 16777215 })
          .toString(16)}`,
        team: d.teams ? faker.random.number({ min: 0, max: 1 }) : undefined,
        name: faker.internet.userName(),
        score: faker.random.number({ min: 0, max: 18 }),
        serviceTag: Array(faker.random.number({ min: 3, max: 4 }))
          .fill()
          .reduce(a => a + faker.random.arrayElement(serviceTagAlphabet), "")
      }));
    const variantMap = {
      slayer: ["Team Slayer", "Slayer"],
      infection: ["Alpha Zombie", "Zombies"],
      assault: ["Neutral Bomb", "Assault"],
      koth: ["Crazy King", "King of the Hill"],
      oddball: ["FFA Oddball", "Oddball"],
      juggernaut: ["Juggernaut"],
      ctf: ["Multi Flag", "Capture the Flag"],
      none: ["none"]
    };
    return {
      ...d,
      numPlayers: players.length,
      maxPlayers: players.length > 8 ? 16 : faker.random.boolean() ? 16 : 8,
      teamScores:
        !d.passworded && d.teams && Boolean(players.length)
          ? players.reduce(
              (acc, { team, score }) => {
                acc[team] = acc[team] + score;
                return acc;
              },
              [0, 0]
            )
          : undefined,
      variant: faker.random.arrayElement(variantMap[d.variantType]),
      players: !d.passworded ? players : undefined
    };
  });
