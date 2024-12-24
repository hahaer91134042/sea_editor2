<template>
    <div class=" container p-2 ">
        <div class="row mb-2 align-items-center">
            <div class="col col-1" style="">
                <span class="" style="height: 35px;">LOOP:</span>
            </div>

            <div class="col col-7" style="">
                <div class=" input-group  input-group-sm">
                    <input class=" form-control" style="width: 50px;" type="number" v-model="betConfig.loopNum"
                        :placeholder="$t('number_of_entries')" />
                    <select class="form-select" v-model="betConfig.selectLoop" @change="betConfig.onChangeLoop()">
                        <template v-for="(v, i) in betConfig.loop" :key="i">
                            <option :value="v">{{ numberWithCommas(v) }}</option>
                        </template>
                    </select>
                    <span class=" input-group-text ">{{ $t('thread') }}:</span>
                    <select class="form-select" v-model="betConfig.threadNum">

                        <template v-for="(o, i) in Common.thread.nums" :key="i">
                            <option :value="o">x {{ o }}</option>
                        </template>

                    </select>
                    <span class=" input-group-text ">{{ $t('mode_of_operation') }}:</span>
                    <select class="form-select" v-model="betConfig.mode">
                        <option selected value="0">{{ $t('single_gear') }}</option>
                        <option value="1">{{ $t('reality') }}</option>
                    </select>
                    <input v-show="betConfig.mode == 1" v-model="betConfig.realityPath"
                        @click="betConfig.onSelectRealityDir()" class="form-control " placeholder="選擇真實路徑"
                        style="width: 50px;" readonly v-tooltip :title="betConfig.realityPath"
                        data-bs-placement="bottom" />
                </div>

            </div>
            <div class="col ">
                <div class="input-group" style="width: 150px;" v-show="(betConfig.luaLv > -1) && (betConfig.mode == 1)">
                    <span class="input-group-text">{{ $t('gear') }}:</span>
                    <select class="form-select form-select-sm " v-model="betConfig.luaLv">
                        <template v-for="(v) in betConfig.fileLv" :key="v">
                            <option :value="v">{{ v }}</option>
                        </template>
                    </select>
                </div>

            </div>
            <div class="input-group-text col">
                <input class="form-check-input" type="checkbox" v-model="betConfig.gameLog" value="" />
                <label>{{ $t("game_log") }}</label>
            </div>

        </div>
        <div class="row mb-2 row-cols-auto align-items-center" style="width:1200px">

            <div class="col col-4">
                <div class="input-group ">

                    <select class="form-select" v-model="betConfig.bet.size" @change="betConfig.onBetChange()">
                        <option disabled value="0">{{ $t('place_bet') }}</option>

                        <template v-for="(v, i) in betConfig.selectBet" :key="i">
                            <option :value="v">{{ v }}</option>
                        </template>
                    </select>
                    <span class="input-group-text">x</span>
                    <select class="form-select" v-model="betConfig.bet.multi" @change="betConfig.onBetChange()">
                        <option disabled value="0">{{ $t('multiply') }}</option>

                        <template v-for="(v, i) in betConfig.selectBetMulti" :key="i">
                            <option :value="v">{{ v }}</option>
                        </template>
                    </select>
                    <!-- <span class="input-group-text">x {{ betConfig.bet.base }}</span> -->
                    <span class="input-group-text">=</span>
                    <input type="text" class="form-control" :placeholder="$t('bet_amount')" readonly
                        v-model="betConfig.bet.num" />
                </div>

            </div>
            <div class="col" style="">
                <div class=" input-group " style="width:160px;">
                    <span class="input-group-text">{{ $t("level") }}:</span>
                    <select class="form-select" v-model="betConfig.gameLevel">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="0">{{ $t('continuous') }}</option>
                    </select>
                </div>
            </div>
            <div class="col col-3" style="">
                <!-- checkbox -->
                <div class="input-group">
                    <div class="input-group-text">
                        <input class="form-check-input mt-0" type="checkbox" v-model="output.log" value="" />
                        <label>{{ $t('output_log') }}</label>
                    </div>
                    <input type="text" class="form-control" v-model="output.dirPath" v-tooltip :title="output.dirPath"
                        data-bs-placement="bottom" />
                    <button class="btn btn-outline-secondary" style="width:50px;"
                        v-on:click="output.onSelectDir()">...</button>
                </div>
            </div>

            <div class="col" style="">
                <div class="input-group ">
                    <div class="input-group-text">
                        <select class="form-select form-select-sm mt-0" v-model="betConfig.runBatch">
                            <option value="0">{{ $t("one_batch_operations") }}</option>
                            <option value="1">{{ $t("batch_operations") }}</option>
                        </select>

                    </div>
                    <button class="btn btn-outline-secondary" @click="result.runTest()" style="width:100px;"
                        type="button" id="">
                        {{ $t('start_calculation') }}
                    </button>

                </div>
            </div>
        </div>

        <div class=" d-flex flex-row mb-2  overflow-x-auto" style="width: 3000px;">
            <div class="grid-view-y-2 border border-1" style="height: 500px;width: 600px;">
                <template v-for="o in result.objs" :key="o.id">
                    <div class="card" style="height:250px;">
                        <div class="card-header bg-dark text-light">
                            <span>{{ o.name }} </span>
                            <label>({{ result.calObjValue(o.id).ratio }}%)</label>
                        </div>
                        <div class="card-body table-responsive p-0">
                            <table class="table table-striped table-hover" style="font-size:x-small;">
                                <tbody>
                                    <template v-for="(c, i) in o.content" :key="i">
                                        <tr class="table-light">
                                            <td>{{ c.type }}</td>
                                            <td>{{ result.calObjValue(o.id, c.type).ratio }}%</td>
                                            <td>{{ result.calObjValue(o.id, c.type).total }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </template>


            </div>

            <div class=" border border-1" style="width: 600px;">
                <div class="border border-2 border-dark text-md-start">
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('start_time') }} :<span>{{ result.during.start }}</span>
                        </div>
                        <div class="col">
                            {{ $t('total_time_spent') }} :<span>{{ result.during.sec }}</span>
                        </div>
                        <div class="col">
                            {{ $t("finish") }}:<span>{{ `${betConfig.nowLoop}/${betConfig.loopNum}` }}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            {{ $t('total_revenue') }} :<span>{{ result.data.TP }}</span>
                        </div>
                        <div class="col">
                            {{ $t('trtp') }} :<span>{{ result.data.TRTP }}%</span>
                        </div>
                        <div class="col"></div>
                    </div>
                </div>

                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5>{{ $t('mainGame') }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('mtrp') }} :<span>{{ result.data.normal.MRTP }}%</span>
                        </div>
                        <div class="col">
                            {{ $t('total_revenue') }} :<span>{{ result.data.normal.TP }}</span>
                        </div>
                        <div class="col">
                            {{ $t('tax_amount') }} :<span>0</span>
                        </div>
                    </div>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('highest_profit_in_a_single') }} :<span>{{ result.data.normal.maxPrize }}</span>
                        </div>
                        <div class="col">
                            {{ $t('number_of_times_won') }} :<span>{{ result.data.normal.PfCnt }}</span>
                        </div>
                        <div class="col">
                            {{ $t('odds_of_winning') }} :<span>{{ roundTo(result.data.normal.nPfCntPnt * 100)
                                }}%</span>
                        </div>
                    </div>

                </div>

                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5>{{ $t('freeSpin') }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('number_of_times_won') }} :<span>{{ result.data.free.PfCnt }}</span>
                        </div>
                        <div class="col">
                            {{ $t('total') }} :<span>{{ result.data.free.Rs }}</span>{{ $t('round') }}
                        </div>
                    </div>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('total_revenue') }} :<span>{{ result.data.free.TP }}</span>
                        </div>
                    </div>

                </div>
                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5>JP</h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover text-center table-borderless align-middle">
                            <thead class="">
                                <tr>
                                    <th></th>
                                    <th>{{ `${$t("cumulative_prizes")}(${$t("frequency")})` }}</th>
                                    <th>{{ $t("total_revenue") }}</th>
                                    <th>{{ `${$t("odds_of_winning")}(%)` }}</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <template v-for="(jp, i) in result.jp" :key="i">
                                    <tr class="">
                                        <td scope="row">{{ `Jackpot ${jp[0]}` }}</td>
                                        <td>{{ jp[1] }}</td>
                                        <td>{{ jp[2] }}</td>
                                        <td>{{ `${jp[3]} %` }}</td>
                                    </tr>
                                </template>

                            </tbody>
                        </table>
                    </div>

                </div>

            </div>

            <div class="overflow-auto" style="height: 500px;">
                <!-- 4*4 -->
                <div class=" border border-2 border-black mb-2 p-2 " style="width: fit-content;">
                    <div class="" style="">
                        <!-- row -->
                        <template v-for="(a, i) in result.ui.round1" :key="i">
                            <div class=" d-flex mb-1" :style="result.ui.rowStyle">
                                <template v-for="(b, j) in a" :key="j">
                                    <div class="me-1" style="" :style="[result.ui.colStyle, b.bg]">{{ `${b.x},${b.y}` }}
                                    </div>
                                </template>
                            </div>
                        </template>

                    </div>
                </div>

                <!-- 5*5 -->
                <div class=" border border-2 border-black mb-2 p-2 " style="width: fit-content;">
                    <div class="" style="">
                        <!-- row -->
                        <template v-for="(a, i) in result.ui.round2" :key="i">
                            <div class=" d-flex mb-1" :style="result.ui.rowStyle">
                                <template v-for="(b, j) in a" :key="j">
                                    <div class="me-1" style="" :style="[result.ui.colStyle, b.bg]">{{ `${b.x},${b.y}` }}
                                    </div>
                                </template>
                            </div>
                        </template>

                    </div>
                </div>


                <!-- 6*6 -->
                <div class=" border border-2 border-black mb-2 p-2 " style="width: fit-content;">
                    <div class="" style="">
                        <!-- row -->
                        <template v-for="(a, i) in result.ui.round3" :key="i">
                            <div class=" d-flex mb-1" :style="result.ui.rowStyle">
                                <template v-for="(b, j) in a" :key="j">
                                    <div class="me-1" style="" :style="[result.ui.colStyle, b.bg]">{{ `${b.x},${b.y}` }}
                                    </div>
                                </template>
                            </div>
                        </template>

                    </div>
                </div>


            </div>

        </div>

    </div>
</template>

<script setup>
import * as _ from 'lodash'
import { inject, reactive, toRefs, watch, computed } from 'vue'
import { Common, CandyParty } from '@/config/GameConfig'
import { tryObjToArray, roundTo, numberWithCommas, selectDirFiles } from '@/plugin/Utils'
import * as dll from '@/plugin/native/CandyParty'
import { ProvideFlag } from '@/config/Enum'
import moment from 'moment'
import ColorView from '@/views/components/ColorBgView'

const log = inject(ProvideFlag.log)

const api = require("@/ElectronApi")



const lua = inject(ProvideFlag.lua)
const parent = inject(ProvideFlag.parent)


let progress = parent.progress
//parent.value.showDialog()
let hd = 100

watch(lua, () => {

    //每次更換設定檔使用初始值
    betConfig.bet.size = lua.value.bets.map(v => v / hd).min()
    betConfig.bet.multi = 5
    betConfig.onBetChange()
})

let betConfig = reactive({
    loopNum: 10000,
    nowLoop: 0,
    selectLoop: 10000,
    loop: [1, 10, 100, 1000, 10000, 20000, 100000, 1000000],
    onChangeLoop: () => betConfig.loopNum = betConfig.selectLoop,
    mode: '0',//運作方式 0:單檔 1:真實
    threadNum: Common.thread.def,
    realityPath: '',
    luaLv: -1,
    runBatch: 0,
    fileLv: [],
    gameLog: false,//遊戲日誌
    gameLevel: 1,//關卡
    selectBet: computed({
        get: function () {
            if (!lua.value)
                return []
            return lua.value.bets.map(v => v / hd)
        }
    }),
    selectBetMulti: computed({
        get: function () {
            if (!lua.value)
                return []
            return [3, 4, 5]
        }
    }),
    bet: {
        num: '',//下注總額
        size: 0,
        multi: 0,
        // base: computed({
        //     get: function () {
        //         if (!lua.value)
        //             return 0
        //         return lua.value.bets.Base
        //     }
        // })
    },
    onBetChange: function () {
        let s = betConfig.bet.size
        let m = betConfig.bet.multi
        // let b = betConfig.bet.base
        betConfig.bet.num = s * m
    },
    onSelectRealityDir() {
        api.openDir()
            .then(res => {
                if (!res.filePaths[0])
                    return

                console.log('selected directory:' + res.filePaths[0]);
                betConfig.realityPath = res.filePaths[0]

                log.debug(`select reality dir:${betConfig.realityPath}`)

                let luaLv = []
                selectDirFiles(betConfig.realityPath)
                    .forEach(file => {
                        // console.log(`selectDirFile name->${file}`)
                        // console.log(`charAt 0->${file.charAt(0)}`)
                        // console.log(`charAt 1->${file.charAt(1)}`)
                        // console.log(`charAt 2->${file.charAt(2)}`)
                        // console.log(`charAt 3->${file.charAt(3)}`)
                        // console.log(`charAt 4->${file.charAt(4)}`)
                        var num = Number(file.charAt(0))
                        if (num >= 0)
                            luaLv.push(num)
                    })
                //console.log(`select lv raw->${luaLv}`)
                betConfig.fileLv = _.uniq(luaLv)
                betConfig.luaLv = betConfig.fileLv.first()
                //console.log(`select lv uniq->${luaLv}`)

            });
    }

})

//const {remote}= require('electron')


let output = reactive({
    log: false,
    dirPath: '',
    onSelectDir: function () {
        // remote.dialog.showOpenDialog({
        //     properties: ['openDirectory'],
        //     defaultPath: ''
        // }).then(res => {
        //     console.log('selected directory:' + res.filePaths[0]);
        //     dirPath.value = res.filePaths[0]
        // });
        api.openDir()
            .then(res => {
                console.log('selected directory:' + res.filePaths[0]);
                output.dirPath = res.filePaths[0]
                log.debug(`select log output dir:${output.dirPath}`)
            });
    }
})



let result = reactive({
    during: {
        start: '',
        sec: ''
    },
    data: getNewResultData(),
    jp: computed({
        get: function () {
            return result.data.JP.Time.map(t => {
                let prize = result.data.JP.Prize.first(p => t[0] == p[0])
                let rtp = result.data.JP.RTP.first(r => t[0] == r[0])
                return [t[0], t[1], prize[1], rtp[1]]
            })
        }
    }),
    ui: {
        colStyle: { width: '150px' },
        rowStyle: { height: '100px' },
        round1: [].also(a => {
            let row = 4
            let col = 4
            let bg = [
                ['rgb(0,128,0)', 'rgb(0,175,0)', 'rgb(0,255,0)', 'rgb(255,242,0)'],
                ['rgb(0,135,0)', 'rgb(0,167,0)', 'rgb(0,255,0)', 'rgb(255,126,0)'],
                ['rgb(0,151,0)', 'rgb(0,183,0)', 'rgb(255,250,0)', 'rgb(255,110,0)'],
                ['rgb(0,175,0)', 'rgb(31,255,0)', 'rgb(255,118,0)', 'rgb(255,0,0)'],
            ]

            for (let y = 0; y < row; y++) {
                let b = []
                for (let x = 0; x < col; x++) {
                    b.push({ x: x, y: y, bg: { 'background-color': bg[y][x] } })
                }
                a.push(b)
            }

        }),
        round2: [].also(a => {
            let row = 5
            let col = 5
            let bg = [
                ['rgb(0, 128, 0)', 'rgb(0, 153, 0)', 'rgb(0, 178, 0)', 'rgb(25, 255, 0)', 'rgb(255, 128, 0)'],
                ['rgb(0, 133, 0)', 'rgb(0, 158, 0)', 'rgb(0, 183, 0)', 'rgb(35, 255, 0)', 'rgb(255, 122, 0)'],
                ['rgb(0, 143, 0)', 'rgb(0, 168, 0)', 'rgb(5, 255, 0)', 'rgb(255, 246, 0)', 'rgb(255, 112, 0)'],
                ['rgb(0, 158, 0)', 'rgb(0, 183, 0)', 'rgb(35, 255, 0)', 'rgb(255, 122, 0)', 'rgb(255, 0, 0)'],
                ['rgb(0, 178, 0)', 'rgb(25, 255, 0)', 'rgb(255, 235, 0)', 'rgb(255, 0, 0)', 'rgb(255, 0, 0)']
            ]

            for (let y = 0; y < row; y++) {
                let b = []
                for (let x = 0; x < col; x++) {
                    b.push({ x: x, y: y, bg: { 'background-color': bg[y][x] } })
                }
                a.push(b)
            }

        }),
        round3: [].also(a => {
            let row = 6
            let col = 6
            let bg = [
                ['rgb(0, 128, 0)', 'rgb(0, 149, 0)', 'rgb(0, 170, 0)', 'rgb(0, 255, 0)', 'rgb(255, 252, 0)', 'rgb(255, 123, 0)'],
                ['rgb(0, 131, 0)', 'rgb(0, 152, 0)', 'rgb(0, 173, 0)', 'rgb(7, 255, 0)', 'rgb(255, 249, 0)', 'rgb(255, 120, 0)'],
                ['rgb(0, 138, 0)', 'rgb(0, 159, 0)', 'rgb(0, 180, 0)', 'rgb(21, 255, 0)', 'rgb(255, 242, 0)', 'rgb(255, 113, 0)'],
                ['rgb(0, 149, 0)', 'rgb(0, 170, 0)', 'rgb(0, 255, 0)', 'rgb(255, 252, 0)', 'rgb(255, 123, 0)', 'rgb(255, 0, 0)'],
                ['rgb(0, 163, 0)', 'rgb(0, 184, 0)', 'rgb(28, 255, 0)', 'rgb(255, 238, 0)', 'rgb(255, 109, 0)', 'rgb(255, 0, 0)'],
                ['rgb(0, 180, 0)', 'rgb(21, 255, 0)', 'rgb(255, 242, 0)', 'rgb(255, 113, 0)', 'rgb(255, 0, 0)', 'rgb(255, 0, 0)']
            ]

            for (let y = 0; y < row; y++) {
                let b = []
                for (let x = 0; x < col; x++) {
                    b.push({ x: x, y: y, bg: { 'background-color': bg[y][x] } })
                }
                a.push(b)
            }

        }),
    },
    objs: computed({
        get: function () {
            if (!lua.value)
                return []

            let d = lua.value.levels[betConfig.gameLevel == 0 ? 0 : (betConfig.gameLevel - 1)]
                .objs.map(o => CandyParty.DataObj(o))
                .filter(o => {//過濾出有支援的obj
                    if (result.data.tiles[`Obj${o.id}`])
                        return true
                    return false
                })
            //console.log(`result objs->${d.jsonString()}`)
            return d

        }
    }),
    calObjValue: function (id, type = null) {

        let o = result.data.tiles[`Obj${id}`]
        if (!o)
            return { total: 0, ratio: 0 }

        if (type) {
            let xReg = /X[0-9]+/
            let sReg = /S[0-9]+/

            switch (id) {
                case 1://key
                case 7://bonus                
                    return {
                        total: o.sum(),
                        ratio: roundTo(o.sum() / result.data.TR * 100)
                    }
                case 2:
                case 3:
                case 4:
                case 5:
                case 6: {
                    if (!xReg.test(type))
                        return { total: 0, ratio: 0 }

                    let offset = 4//const4才開始算
                    let i = Number(type.substring(1))
                    i = (i - offset) >= 0 ? (i - offset) : -1
                    //console.log(`type->${type} i->${i}`)

                    if (i >= 0)
                        return {
                            total: o[i],
                            ratio: roundTo(o[i] / result.data.TR * 100)
                        }

                    return { total: 0, ratio: 0 }
                }
                case 8: {//JP
                    if (!sReg.test(type))
                        return { total: 0, ratio: 0 }

                    let offset = 1//S1才開始算
                    let i = Number(type.substring(1))
                    i = (i - offset) >= 0 ? (i - offset) : -1
                    //console.log(`type->${type} i->${i}`)

                    if (i >= 0)
                        return {
                            total: o[i],
                            ratio: roundTo(o[i] / result.data.TR * 100)
                        }

                    return { total: 0, ratio: 0 }
                }

                default:
                    return { total: 0, ratio: 0 }
            }


        } else {
            return {
                total: o.sum(),
                ratio: roundTo(o.sum() / result.data.TR * 100)
            }
        }

    },
    runTest: function () {
        if (betConfig.bet.num < 1) {
            parent.showDialog({ msg: window.$t('please_enter_the_bet_amount_first') })
            return
        }


        if (betConfig.loopNum < 1) {
            parent.showDialog({ msg: window.$t('please_enter_the_number_of_rounds_first') })
            return
        }

        if (betConfig.mode == 1 && betConfig.realityPath.length < 1) {
            parent.showDialog({ msg: window.$t('please_select_the_real_folder_path_first') })
            return
        }

        if (output.log && output.dirPath.length < 1) {
            parent.showDialog({ msg: window.$t('please_select_the_Log_path_first') })
            return
        }



        parent.saveLua()

        let start = moment()
        let config = {
            betNum: betConfig.bet.num,
            round: betConfig.loopNum,
            thread: betConfig.threadNum,
            path: betConfig.mode == 0 ? parent.getLoadFilePath() : '',
            dir: betConfig.mode == 1 ? betConfig.realityPath : '',
            luaLv: betConfig.luaLv,
            log: output.log ? output.dirPath : '',
            gameLog: betConfig.gameLog,
            gameLv: betConfig.gameLevel
        }
        log.warn({
            msg: `param:${{
                betAmount: Number(config.betNum),
                runTimes: Number(config.round),
                threadNum: Number(config.thread),
                luaPath: config.path,
                luaFolder: config.dir,
                luaLevel: Number(config.luaLv),
                logFolder: config.log,
                GameLog: config.gameLog,
                GameLevel: Number(config.gameLv)
            }.jsonString()}`
        })

        result.during.start = start.format(Common.format.fullTime)
        result.during.sec = ''
        betConfig.nowLoop = 0
        result.data = getNewResultData()


        switch (betConfig.runBatch.toNum()) {
            case 1: {
                setTimeout(() => {

                    dll.calResult(config, (round, data) => {
                        console.log(`async run view round->${round}`)
                        console.log(data.jsonString())
                        log.warn({
                            msg: `result:${data.jsonString()}`
                        })
                        betConfig.nowLoop = round

                        mergeData(data)

                        if (betConfig.nowLoop == betConfig.loopNum) {
                            let end = moment()
                            result.during.sec = `${end.diff(start, 'milliseconds') / 1000}${window.$t('sec')}`
                        }
                    })
                }, 300)

                break;
            }
            default: {
                progress.show(() => {
                    let res = dll.calResult(config)
                    console.log(`run result->${res.jsonString()}`)
                    log.warn({
                        msg: `result:${res.jsonString()}`
                    })
                    progress.hide()
                    result.data = res
                    let end = moment()
                    betConfig.nowLoop = betConfig.loopNum
                    //result.during.start = start.format(Common.format.fullTime)
                    result.during.sec = `${end.diff(start, 'milliseconds') / 1000}${window.$t('sec')}`
                })
                break;
            }
        }

    }

})

function mergeData(n) {
    let totalBet = (betConfig.bet.num * betConfig.loopNum)
    let raw = result.data

    raw.TP = raw.TP.toNum() + n.TP.toNum()
    raw.TR = raw.TP.toNum() + n.TR.toNum()
    raw.TRTP = roundTo((raw.TP / totalBet) * 100)

    raw.normal.PfCnt = raw.normal.PfCnt.toNum() + n.normal.PfCnt.toNum()
    raw.normal.TP = raw.normal.TP.toNum() + n.normal.TP.toNum()
    raw.normal.maxPrize = n.normal.maxPrize.toNum() > raw.normal.maxPrize.toNum() ?
        n.normal.maxPrize.toNum() : raw.normal.maxPrize.toNum()
    raw.normal.nPfCntPnt = (raw.normal.PfCnt / betConfig.loopNum)
    raw.normal.MRTP = roundTo((raw.normal.TP / totalBet) * 100)

    raw.free.PfCnt = raw.free.PfCnt.toNum() + n.free.PfCnt.toNum()
    raw.free.Rs = raw.free.Rs.toNum() + n.free.Rs.toNum()
    raw.free.TP = raw.free.TP.toNum() + n.free.TP.toNum()
    //raw.free.RTP = roundTo((raw.free.TP / (betConfig.bet.num * betConfig.loopNum)) * 100)

    for (const obj in n.tiles) {
        //console.log(`obj->${obj} raw tiles->${raw.tiles[obj].jsonString()}`)
        // if (!raw.tiles[obj]) {

        // } else {

        // }
        if (!raw.tiles[obj] || raw.tiles[obj].length < 1) {
            raw.tiles[obj] = n.tiles[obj]
        } else {
            for (let i = 0; i < n.tiles[obj].length; i++) {
                raw.tiles[obj][i] = raw.tiles[obj][i] + n.tiles[obj][i]
            }
        }
    }

    raw.JP.Prize.forEach(p2 => {
        p2[1] = n.JP.Prize.first(p1 => p1[0] == p2[0])[1] + p2[1]

    })
    raw.JP.Time.forEach(t2 => {
        t2[1] = n.JP.Time.first(t1 => t1[0] == t2[0])[1] + t2[1]
    })

    raw.JP.RTP.forEach(r => {
        r[1] = roundTo((raw.JP.Prize.first(p => r[0] == p[0])[1] / totalBet) * 100)
    })

}

function getNewResultData() {
    return {
        "JP":
        {
            "Prize": [
                [1, 0],
                [2, 0],
                [3, 0],
                [4, 0]
            ],
            "RTP": [
                [1, 0],
                [2, 0],
                [3, 0],
                [4, 0]
            ],
            "Time": [
                [1, 0],
                [2, 0],
                [3, 0],
                [4, 0]
            ]
        },
        "TP": 0,
        "TR": 0,
        "TRTP": 0,
        "free": { "PfCnt": 0, "Rs": 0, "TP": 0 },
        "normal": {
            "MRTP": 0, "PfCnt": 0, "TP": 0,
            "getFT": [], "maxPrize": 0, "nPfCntPnt": 0
        },
        "tiles": {
            "Obj1": [],
            "Obj2": [],
            "Obj3": [],
            "Obj4": [],
            "Obj5": [],
            "Obj6": [],
            "Obj7": [],
            "Obj8": [] //JP
        }
    }
}


</script>

<style></style>