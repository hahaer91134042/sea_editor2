const { tryObjToArray, tryZero } = require('@/plugin/Utils')
const moment = require('moment')
const { Page } = require('@/config/Enum')

class GameDataFlag {
  /**
   *自動初始化抓取檔案的flag物件
   * @param {string} project project name
   * @param {string} file file name
   * @param  {...{flag:string,rule:Function}} args
   */
  constructor (project, file, ...args) {
    for (const i of args) {
      this[i.flag] = i.rule(project, file)
    }
  }
}

const MahJongWays = {
  /**
   * 此為每個遊戲config的必要設定 都必須實作
   * @param {string} projectName 專案(模板)名稱
   * @param {string} fileName 檔案名稱
   * @returns
   */
  dataFlag: function (projectName, fileName) {
    return new GameDataFlag(
      projectName,
      fileName,
      {
        flag: Page.Main,
        rule: function (p, f) {
          return `${p}${f}`
        }
      },
      {
        flag: Page.Freespin,
        rule: function (p, f) {
          return `${p}${f}_FreeSpin`
        }
      }
    )
  },

  /**
   * 遊戲轉軸設定
   */
  Rolls: [{ num: 1 }, { num: 2 }, { num: 3 }, { num: 4 }, { num: 5 }],
  ObjEvent: {
    0: 'LineBet x',
    3: 'TotalBet x',
    4: 'FreeSpin x(num)'
  },
  /**
   *
   * @param {*} obj objs item
   * @returns { id,name,icon,k,conetnt:[{type,event,param}]}
   */
  DataObj: function (obj) {
    let c = []
    let w = tryObjToArray(obj.wild)
    if (w.length > 0)
      c.push({ type: 'W', event: 'WILD work with', param: w.join() })

    for (const key in obj) {
      if (!key.includes('cont')) continue
      const contList = obj[key]
      contList.forEach(cont => {
        c.push({
          type: key.replace('cont', 'X'),
          event: cont.event,
          param: cont.param
        })
      })
    }

    for (const key in obj.scatter) {
      if (!key.includes('cont')) continue
      const contList = obj.scatter[key]

      contList.forEach(cont => {
        c.push({
          type: key.replace('cont', 'S'),
          event: cont.event,
          param: cont.param
        })
      })
    }

    return {
      id: obj.id,
      name: obj.name,
      icon: obj.icon,
      k: obj.k,
      scatter: { flag: obj.scatter.flag },
      content: c,
      is_ChangeID: obj.is_ChangeID ? obj.is_ChangeID : 0,
      disable_copy: obj.disable_copy
    }
  },
  LuaObj: function (obj) {
    let w =
      obj.content
        .first(o => o.type == 'W')
        ?.param?.split(',')
        .map(v => tryZero(v)) ?? []

    let r = {
      id: obj.id,
      name: obj.name,
      icon: obj.icon,
      k: obj.k
    }
    let xReg = /X[0-9]+/

    obj.content
      .filter(c => xReg.test(c.type))
      .forEach(c => {
        let key = c.type.replace('X', 'cont')

        if (!r[key]) r[key] = []

        r[key].push({
          event: c?.event?.toNum() ?? 0,
          param: c?.param?.toNum() ?? 0
        })
      })

    let s = {
      flag: obj.scatter.flag
    }

    let sReg = /S[0-9]+/

    obj.content
      .filter(c => sReg.test(c.type))
      .forEach(c => {
        let key = c.type.replace('S', 'cont')

        if (!s[key]) s[key] = []

        s[key].push({
          event: c?.event?.toNum() ?? 0,
          param: c?.param?.toNum() ?? 0
        })
      })

    r.wild = w
    r.scatter = s
    r.disable_copy = obj.disable_copy

    if (obj.is_ChangeID > 0) {
      r.is_ChangeID = 1
    }

    return r
  }
}

const MahJongWays2 = {
  dataFlag: function (projectName, fileName) {
    return new GameDataFlag(
      projectName,
      fileName,
      {
        flag: Page.Main,
        rule: function (p, f) {
          return `${p}${f}`
        }
      },
      {
        flag: Page.Freespin,
        rule: function (p, f) {
          return `${p}${f}_Free`
        }
      }
    )
  }
}

const CandyParty = {
  dataFlag: function (projectName, fileName) {
    return new GameDataFlag(
      projectName,
      fileName,
      {
        flag: Page.Main,
        rule: (p, f) => `${p}${f}`
      },
      {
        flag: Page.Freespin,
        rule: (p, f) => `${p}${f}_FreeSpin`
      },
      {
        flag: Page.Jp,
        rule: (p, f) => `${p}${f}_JP`
      }
    )
  },
  ObjEvent: {
    0: 'LineBet x',
    3: 'TotalBet x',
    4: 'FreeSpin x(num)'
  },
  /**
   *
   * @param {*} obj objs item
   * @returns { id,name,icon,k,conetnt:[{type,event,param}]}
   */
  DataObj: function (obj) {
    let c = []
    let w = tryObjToArray(obj.wild)
    if (w.length > 0)
      c.push({ type: 'W', event: 'WILD work with', param: w.join() })

    if (obj.key == 1) c.push({ type: 'key', event: 'key', param: '' })

    for (const key in obj) {
      if (!key.includes('cont')) continue
      const contList = obj[key]
      contList.forEach(cont => {
        c.push({
          type: key.replace('cont', 'X'),
          event: cont.event,
          param: cont.param
        })
      })
    }

    for (const key in obj.scatter) {
      if (!key.includes('cont')) continue
      const contList = obj.scatter[key]

      contList.forEach(cont => {
        c.push({
          type: key.replace('cont', 'S'),
          event: cont.event,
          param: cont.param
        })
      })
    }

    return {
      id: obj.id,
      name: obj.name,
      icon: obj.icon,
      k: obj.k,
      scatter: { flag: obj?.scatter?.flag ?? false },
      content: c,
      is_ChangeID: obj.is_ChangeID ? obj.is_ChangeID : 0,
      disable_copy: obj.disable_copy
    }
  },
  LuaObj: function (obj) {
    let w =
      obj.content
        .first(o => o.type == 'W')
        ?.param?.split(',')
        .map(v => tryZero(v)) ?? []

    let r = {
      id: obj.id,
      name: obj.name,
      icon: obj.icon,
      k: obj.k,
      key: obj.content.filter(o => o.type == 'key').length > 0 ? 1 : 0
    }
    let xReg = /X[0-9]+/

    obj.content
      .filter(c => xReg.test(c.type))
      .forEach(c => {
        let key = c.type.replace('X', 'cont')

        if (!r[key]) r[key] = []

        r[key].push({
          event: c?.event?.toNum() ?? 0,
          param: c?.param?.toNum() ?? 0
        })
      })

    let s = {
      flag: obj.scatter.flag
    }

    let sReg = /S[0-9]+/

    obj.content
      .filter(c => sReg.test(c.type))
      .forEach(c => {
        let key = c.type.replace('S', 'cont')

        if (!s[key]) s[key] = []

        s[key].push({
          event: c?.event?.toNum() ?? 0,
          param: c?.param?.toNum() ?? 0
        })
      })

    r.wild = w
    r.scatter = s
    r.disable_copy = obj.disable_copy

    if (obj.is_ChangeID > 0) {
      r.is_ChangeID = 1
    }

    return r
  },
  mock: {
    levels: [
      {
        version: {
          data_type: 'HUGA',
          ver: 2
        },
        is_fa: false,
        bets: {
          bet: [3, 10, 30, 90],
          multi: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          Base: 2000
        },
        line_coef: 40,
        prize_den: 100,
        tick_range: {
          low: 1,
          high: 1
        },
        objs: [
          {
            id: 1,
            name: 'Wild',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3, 4, 5, 6, 7, 8, 9, 10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: [],
              cont6: [],
              cont7: [],
              cont8: [],
              cont9: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [1],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 2,
            name: 'Bonus',
            icon: '',
            k: 1,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: true,
              cont1: [],
              cont2: [],
              cont3: [
                {
                  event: 4,
                  param: 12
                }
              ],
              cont4: [
                {
                  event: 4,
                  param: 14
                }
              ],
              cont5: [
                {
                  event: 4,
                  param: 16
                }
              ],
              cont6: [
                {
                  event: 4,
                  param: 18
                }
              ],
              cont7: [
                {
                  event: 4,
                  param: 20
                }
              ],
              cont8: [
                {
                  event: 4,
                  param: 22
                }
              ],
              cont9: [
                {
                  event: 4,
                  param: 24
                }
              ],
              cont10: [
                {
                  event: 4,
                  param: 26
                }
              ],
              cont11: [
                {
                  event: 4,
                  param: 28
                }
              ],
              cont12: [
                {
                  event: 4,
                  param: 30
                }
              ],
              cont13: [
                {
                  event: 4,
                  param: 32
                }
              ],
              cont14: [
                {
                  event: 4,
                  param: 34
                }
              ],
              cont15: [
                {
                  event: 4,
                  param: 36
                }
              ],
              cont16: [
                {
                  event: 4,
                  param: 38
                }
              ],
              cont17: [
                {
                  event: 4,
                  param: 40
                }
              ],
              cont18: [
                {
                  event: 4,
                  param: 42
                }
              ],
              cont19: [
                {
                  event: 4,
                  param: 44
                }
              ],
              cont20: [
                {
                  event: 4,
                  param: 46
                }
              ]
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 3,
            name: 'Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 75
              }
            ],
            cont4: [
              {
                event: 0,
                param: 300
              }
            ],
            cont5: [
              {
                event: 0,
                param: 500
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 5,
              high: 5
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 4,
            name: 'Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 50
              }
            ],
            cont4: [
              {
                event: 0,
                param: 200
              }
            ],
            cont5: [
              {
                event: 0,
                param: 400
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 5,
            name: 'Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 40
              }
            ],
            cont4: [
              {
                event: 0,
                param: 100
              }
            ],
            cont5: [
              {
                event: 0,
                param: 300
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 6,
            name: '8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 30
              }
            ],
            cont4: [
              {
                event: 0,
                param: 75
              }
            ],
            cont5: [
              {
                event: 0,
                param: 200
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 7,
            name: '5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 8,
            name: '5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 9,
            name: '2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 10,
            name: '2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 11,
            name: '#Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 12,
            name: '#Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [4],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 13,
            name: '#Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [5],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 14,
            name: '#8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [6],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 15,
            name: '#5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [7],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 16,
            name: '#5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [8],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 17,
            name: '#2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [9],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 18,
            name: '#2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          }
        ],
        groups: [],
        prize_multi: [1, 2, 3, 5],
        rolls: {
          rolls: [
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ]
          ]
        },
        kick_out: {
          multiple: [],
          quota: [],
          total: 100
        },
        uc: {
          uc_type: 'UC_MUTEX',
          total: 0,
          rolls: [
            {
              order: 16,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 14,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 12,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 10,
              relation: [],
              columncopy: [],
              uncopy: [],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 0,
              uc: 100,
              total: 100
            },
            {
              order: 26,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 24,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 22,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 20,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 36,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 34,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 32,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 30,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 46,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 44,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 42,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 40,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 56,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 54,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 52,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            }
          ],
          order: [
            4, 3, 2, 1, 8, 7, 6, 5, 12, 11, 10, 9, 16, 15, 14, 13, 20, 19, 18,
            17
          ]
        },
        sa: {
          items: [],
          total: 10
        }
      },
      {
        version: {
          data_type: 'HUGA',
          ver: 2
        },
        is_fa: false,
        bets: {
          bet: [3, 10, 30, 90],
          multi: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          Base: 2000
        },
        line_coef: 40,
        prize_den: 100,
        tick_range: {
          low: 1,
          high: 1
        },
        objs: [
          {
            id: 1,
            name: 'Wild',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3, 4, 5, 6, 7, 8, 9, 10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: [],
              cont6: [],
              cont7: [],
              cont8: [],
              cont9: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [1],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 2,
            name: 'Bonus',
            icon: '',
            k: 1,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: true,
              cont1: [],
              cont2: [],
              cont3: [
                {
                  event: 4,
                  param: 12
                }
              ],
              cont4: [
                {
                  event: 4,
                  param: 14
                }
              ],
              cont5: [
                {
                  event: 4,
                  param: 16
                }
              ],
              cont6: [
                {
                  event: 4,
                  param: 18
                }
              ],
              cont7: [
                {
                  event: 4,
                  param: 20
                }
              ],
              cont8: [
                {
                  event: 4,
                  param: 22
                }
              ],
              cont9: [
                {
                  event: 4,
                  param: 24
                }
              ],
              cont10: [
                {
                  event: 4,
                  param: 26
                }
              ],
              cont11: [
                {
                  event: 4,
                  param: 28
                }
              ],
              cont12: [
                {
                  event: 4,
                  param: 30
                }
              ],
              cont13: [
                {
                  event: 4,
                  param: 32
                }
              ],
              cont14: [
                {
                  event: 4,
                  param: 34
                }
              ],
              cont15: [
                {
                  event: 4,
                  param: 36
                }
              ],
              cont16: [
                {
                  event: 4,
                  param: 38
                }
              ],
              cont17: [
                {
                  event: 4,
                  param: 40
                }
              ],
              cont18: [
                {
                  event: 4,
                  param: 42
                }
              ],
              cont19: [
                {
                  event: 4,
                  param: 44
                }
              ],
              cont20: [
                {
                  event: 4,
                  param: 46
                }
              ]
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 3,
            name: 'Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 75
              }
            ],
            cont4: [
              {
                event: 0,
                param: 300
              }
            ],
            cont5: [
              {
                event: 0,
                param: 500
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 5,
              high: 5
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 4,
            name: 'Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 50
              }
            ],
            cont4: [
              {
                event: 0,
                param: 200
              }
            ],
            cont5: [
              {
                event: 0,
                param: 400
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 5,
            name: 'Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 40
              }
            ],
            cont4: [
              {
                event: 0,
                param: 100
              }
            ],
            cont5: [
              {
                event: 0,
                param: 300
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 6,
            name: '8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 30
              }
            ],
            cont4: [
              {
                event: 0,
                param: 75
              }
            ],
            cont5: [
              {
                event: 0,
                param: 200
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 7,
            name: '5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 8,
            name: '5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 9,
            name: '2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 10,
            name: '2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 11,
            name: '#Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 12,
            name: '#Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [4],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 13,
            name: '#Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [5],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 14,
            name: '#8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [6],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 15,
            name: '#5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [7],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 16,
            name: '#5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [8],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 17,
            name: '#2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [9],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 18,
            name: '#2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          }
        ],
        groups: [],
        prize_multi: [1, 2, 3, 5],
        rolls: {
          rolls: [
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ]
          ]
        },
        kick_out: {
          multiple: [],
          quota: [],
          total: 100
        },
        uc: {
          uc_type: 'UC_MUTEX',
          total: 0,
          rolls: [
            {
              order: 16,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 14,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 12,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 10,
              relation: [],
              columncopy: [],
              uncopy: [],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 0,
              uc: 100,
              total: 100
            },
            {
              order: 26,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 24,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 22,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 20,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 36,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 34,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 32,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 30,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 46,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 44,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 42,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 40,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 56,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 54,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 52,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            }
          ],
          order: [
            5, 10, 15, 20, 25, 4, 9, 14, 19, 24, 3, 8, 13, 18, 23, 2, 7, 12, 17,
            22, 1, 6, 11, 16, 21
          ]
        },
        sa: {
          items: [],
          total: 10
        }
      },
      {
        version: {
          data_type: 'HUGA',
          ver: 2
        },
        is_fa: false,
        bets: {
          bet: [3, 10, 30, 90],
          multi: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          Base: 2000
        },
        line_coef: 40,
        prize_den: 100,
        tick_range: {
          low: 1,
          high: 1
        },
        objs: [
          {
            id: 1,
            name: 'Wild',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3, 4, 5, 6, 7, 8, 9, 10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: [],
              cont6: [],
              cont7: [],
              cont8: [],
              cont9: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [1],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 2,
            name: 'Bonus',
            icon: '',
            k: 1,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: true,
              cont1: [],
              cont2: [],
              cont3: [
                {
                  event: 4,
                  param: 12
                }
              ],
              cont4: [
                {
                  event: 4,
                  param: 14
                }
              ],
              cont5: [
                {
                  event: 4,
                  param: 16
                }
              ],
              cont6: [
                {
                  event: 4,
                  param: 18
                }
              ],
              cont7: [
                {
                  event: 4,
                  param: 20
                }
              ],
              cont8: [
                {
                  event: 4,
                  param: 22
                }
              ],
              cont9: [
                {
                  event: 4,
                  param: 24
                }
              ],
              cont10: [
                {
                  event: 4,
                  param: 26
                }
              ],
              cont11: [
                {
                  event: 4,
                  param: 28
                }
              ],
              cont12: [
                {
                  event: 4,
                  param: 30
                }
              ],
              cont13: [
                {
                  event: 4,
                  param: 32
                }
              ],
              cont14: [
                {
                  event: 4,
                  param: 34
                }
              ],
              cont15: [
                {
                  event: 4,
                  param: 36
                }
              ],
              cont16: [
                {
                  event: 4,
                  param: 38
                }
              ],
              cont17: [
                {
                  event: 4,
                  param: 40
                }
              ],
              cont18: [
                {
                  event: 4,
                  param: 42
                }
              ],
              cont19: [
                {
                  event: 4,
                  param: 44
                }
              ],
              cont20: [
                {
                  event: 4,
                  param: 46
                }
              ]
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 1
          },
          {
            id: 3,
            name: 'Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 75
              }
            ],
            cont4: [
              {
                event: 0,
                param: 300
              }
            ],
            cont5: [
              {
                event: 0,
                param: 500
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 5,
              high: 5
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 4,
            name: 'Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 50
              }
            ],
            cont4: [
              {
                event: 0,
                param: 200
              }
            ],
            cont5: [
              {
                event: 0,
                param: 400
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 5,
            name: 'Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 40
              }
            ],
            cont4: [
              {
                event: 0,
                param: 100
              }
            ],
            cont5: [
              {
                event: 0,
                param: 300
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 6,
            name: '8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 30
              }
            ],
            cont4: [
              {
                event: 0,
                param: 75
              }
            ],
            cont5: [
              {
                event: 0,
                param: 200
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 7,
            name: '5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 8,
            name: '5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 20
              }
            ],
            cont4: [
              {
                event: 0,
                param: 50
              }
            ],
            cont5: [
              {
                event: 0,
                param: 100
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 9,
            name: '2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 10,
            name: '2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [
              {
                event: 0,
                param: 10
              }
            ],
            cont4: [
              {
                event: 0,
                param: 25
              }
            ],
            cont5: [
              {
                event: 0,
                param: 50
              }
            ],
            full: [],
            scatter_cnt: [],
            wild: [],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            disable_copy: 0
          },
          {
            id: 11,
            name: '#Green',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [3],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 12,
            name: '#Red',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [4],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 13,
            name: '#Blue',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [5],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 14,
            name: '#8W',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [6],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 15,
            name: '#5o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [7],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 16,
            name: '#5i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [8],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 17,
            name: '#2o',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [9],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          },
          {
            id: 18,
            name: '#2i',
            icon: '',
            k: 100,
            cont2: [],
            cont3: [],
            cont4: [],
            cont5: [],
            full: [],
            scatter_cnt: [],
            wild: [10],
            scatter: {
              flag: false,
              cont1: [],
              cont2: [],
              cont3: [],
              cont4: [],
              cont5: []
            },
            scatter_box: {
              flag: false,
              denominator: 0,
              low: 0,
              high: 0
            },
            extra_rate: 0,
            mutex: [],
            roll_mutex: [],
            line_mutex: [],
            is_ChangeID: 1,
            disable_copy: 1
          }
        ],
        groups: [],
        prize_multi: [1, 2, 3, 5],
        rolls: {
          rolls: [
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 950,
                cur_total: 4941
              },
              {
                id: 11,
                drag: 200,
                cur_total: 5141
              },
              {
                id: 12,
                drag: 200,
                cur_total: 5341
              },
              {
                id: 13,
                drag: 200,
                cur_total: 5541
              },
              {
                id: 14,
                drag: 200,
                cur_total: 5741
              },
              {
                id: 15,
                drag: 200,
                cur_total: 5941
              },
              {
                id: 16,
                drag: 200,
                cur_total: 6141
              },
              {
                id: 17,
                drag: 200,
                cur_total: 6341
              },
              {
                id: 18,
                drag: 200,
                cur_total: 6541
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ],
            [
              {
                id: 1,
                drag: 0,
                cur_total: 0
              },
              {
                id: 2,
                drag: 1,
                cur_total: 1
              },
              {
                id: 3,
                drag: 540,
                cur_total: 541
              },
              {
                id: 4,
                drag: 300,
                cur_total: 841
              },
              {
                id: 5,
                drag: 400,
                cur_total: 1241
              },
              {
                id: 6,
                drag: 500,
                cur_total: 1741
              },
              {
                id: 7,
                drag: 600,
                cur_total: 2341
              },
              {
                id: 8,
                drag: 750,
                cur_total: 3091
              },
              {
                id: 9,
                drag: 900,
                cur_total: 3991
              },
              {
                id: 10,
                drag: 1050,
                cur_total: 5041
              }
            ]
          ]
        },
        kick_out: {
          multiple: [],
          quota: [],
          total: 100
        },
        uc: {
          uc_type: 'UC_MUTEX',
          total: 0,
          rolls: [
            {
              order: 16,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 14,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 12,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 25,
              uc: 75,
              total: 100
            },
            {
              order: 10,
              relation: [],
              columncopy: [],
              uncopy: [],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 0,
              uc: 100,
              total: 100
            },
            {
              order: 26,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 24,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 22,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 20,
              relation: [],
              columncopy: [],
              uncopy: [
                {
                  target: 1,
                  weight: 0
                },
                {
                  target: 2,
                  weight: 0
                },
                {
                  target: 3,
                  weight: 0
                },
                {
                  target: 4,
                  weight: 0
                }
              ],
              cp_numerator: 0,
              col_cp_numerator: 0,
              uc_mutex_numerator: 30,
              uc: 70,
              total: 100
            },
            {
              order: 36,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 34,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 32,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 30,
              relation: [
                {
                  target: 1,
                  weight: 25
                },
                {
                  target: 2,
                  weight: 25
                },
                {
                  target: 3,
                  weight: 25
                },
                {
                  target: 4,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 5,
                  weight: 0
                },
                {
                  target: 6,
                  weight: 0
                },
                {
                  target: 7,
                  weight: 0
                },
                {
                  target: 8,
                  weight: 0
                }
              ],
              cp_numerator: 16,
              col_cp_numerator: 0,
              uc_mutex_numerator: 34,
              uc: 50,
              total: 100
            },
            {
              order: 46,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 44,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 42,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 40,
              relation: [
                {
                  target: 5,
                  weight: 25
                },
                {
                  target: 6,
                  weight: 25
                },
                {
                  target: 7,
                  weight: 25
                },
                {
                  target: 8,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 9,
                  weight: 0
                },
                {
                  target: 10,
                  weight: 0
                },
                {
                  target: 11,
                  weight: 0
                },
                {
                  target: 12,
                  weight: 0
                }
              ],
              cp_numerator: 21,
              col_cp_numerator: 0,
              uc_mutex_numerator: 29,
              uc: 50,
              total: 100
            },
            {
              order: 56,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 54,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 52,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            },
            {
              order: 50,
              relation: [
                {
                  target: 9,
                  weight: 25
                },
                {
                  target: 10,
                  weight: 25
                },
                {
                  target: 11,
                  weight: 25
                },
                {
                  target: 12,
                  weight: 25
                }
              ],
              columncopy: [],
              uncopy: [
                {
                  target: 13,
                  weight: 0
                },
                {
                  target: 14,
                  weight: 0
                },
                {
                  target: 15,
                  weight: 0
                },
                {
                  target: 16,
                  weight: 0
                }
              ],
              cp_numerator: 26,
              col_cp_numerator: 0,
              uc_mutex_numerator: 24,
              uc: 50,
              total: 100
            }
          ],
          order: [
            6, 12, 18, 24, 30, 36, 5, 11, 17, 23, 29, 35, 4, 10, 16, 22, 28, 34,
            3, 9, 15, 21, 27, 33, 2, 8, 14, 20, 26, 32, 1, 7, 13, 19, 25, 31
          ]
        },
        sa: {
          items: [],
          total: 10
        }
      }
    ]
  }
}

module.exports = {
  Common: {
    format: {
      fullTime: 'YYYY-MM-DD HH:mm:ss',
      shortTime: 'HH:mm:ss'
    },
    //編輯器支援的線程數
    thread: {
      def: 4, //初始使用線程數
      nums: [1, 2, 4, 6, 8]
    }
  },
  MahJongWays: MahJongWays,
  MahJongWays2: MahJongWays2,
  CandyParty: CandyParty,

  /**
   * 測試用config
   */
  Test: {}
}
