const { Lang } = require('@/config/Lang')

const SupportTemp = {
  DefaultPage: {
    Tabs: []
    // OverAll: null,
    // MainGame: null,
    // FreeSpin: null,
    // JP: null,
    // Emulator: null,
    // Test: null
  },
  List: function () {
    let a = []
    for (const key in SupportTemp.Page) {
      const n = SupportTemp.Page[key].name
      a.push({
        flag: key,
        name: n
      })
    }
    return a
  },
  Page: {
    MahJongWays: {
      name: 'temp.MahJongWays',//i18n裡面的名稱路徑
      Tabs: [
        {
          flag: 'overAll',
          init: true,
          name: "temp.tab.overAll",//i18n裡面的名稱路徑
          view: import('@/views/components/game_MahjongWays/Page_OverAll.vue')
        },
        {
          flag: 'mainGame',
          name: 'temp.tab.mainGame',
          view: import('@/views/components/game_MahjongWays/Page_MainGame.vue')
        },
        {

          flag: 'freeSpin',
          name: 'temp.tab.freeSpin',
          view: import('@/views/components/game_MahjongWays/Page_FreeSpin.vue')
        },
        {
          flag: 'emulator',
          name: 'temp.tab.emulator',
          view: import('@/views/components/game_MahjongWays/Page_Emulator.vue')
        }
      ],
    },
    CandyParty: {
      name: 'temp.CandyParty',
      Tabs: [
        {
          flag: 'overAll',
          init: true,
          name: 'temp.tab.overAll',
          view: import('@/views/components/game_CandyParty/Page_OverAll.vue')
        },
        {
          flag: 'round1',
          name: 'temp.tab.round1',
          view: import('@/views/components/game_CandyParty/Page_Round1.vue')
        },
        {
          flag: 'round2',
          name: 'temp.tab.round2',
          view: import('@/views/components/game_CandyParty/Page_Round2.vue')
        },
        {
          flag: 'round3',
          name: 'temp.tab.round3',
          view: import('@/views/components/game_CandyParty/Page_Round3.vue')
        },
        {
          flag: 'fs_round1',
          name: 'temp.tab.fs_round1',
          view: import('@/views/components/game_CandyParty/Page_Free_Round1.vue')
        },
        {
          flag: 'fs_round2',
          name: 'temp.tab.fs_round2',
          view: import('@/views/components/game_CandyParty/Page_Free_Round2.vue')
        },
        {
          flag: 'fs_round3',
          name: 'temp.tab.fs_round3',
          view: import('@/views/components/game_CandyParty/Page_Free_Round3.vue')
        },
        // {
        //   flag: 'candy_bonus',
        //   name: 'temp.tab.bonus',
        //   view: import('@/views/components/game_CandyParty/Page_Bonus.vue')
        // },
        {
          flag: 'candy_jp',
          name: 'temp.tab.jp',
          view: import('@/views/components/game_CandyParty/Page_JP.vue')
        },
        {
          flag: 'emulator',
          name: 'temp.tab.emulator',
          view: import('@/views/components/game_CandyParty/Page_Emulator.vue')
        }
      ]
    }
    // 'MahJongWays2':{
    //     name:'麻將胡了2',
    //     OverAll:import(`@/views/components/game_MahjongWays2/Page_OverAll.vue`),
    //     MainGame:import(`@/views/components/game_MahjongWays2/Page_MainGame.vue`),
    //     FreeSpin:import(`@/views/components/game_MahjongWays2/Page_FreeSpin.vue`),
    //     Emulator:import(`@/views/components/game_MahjongWays2/Page_Emulator.vue`)
    // }
    // Test: {
    //   name: 'temp.Test',      
    //   Tabs: [
    //     {
    //       flag:'test_page1',
    //       init: true,
    //       name:'temp.tab.test',
    //       view:import(`@/views/components/game_Test/Page_Test.vue`)
    //     }
    //   ]
    // }
  }
}

module.exports = {
  SupportTemp: SupportTemp
}
