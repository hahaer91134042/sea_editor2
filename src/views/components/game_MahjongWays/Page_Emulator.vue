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


        </div>
        <div class="row mb-2 row-cols-auto align-items-center" style="width:100%;">

            <div class="col col-5">
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
                    <span class="input-group-text">x {{ betConfig.bet.base }}</span>
                    <span class="input-group-text">=</span>
                    <input type="text" class="form-control" :placeholder="$t('bet_amount')" readonly
                        v-model="betConfig.bet.num" />
                </div>

            </div>
            <div class="col" style="">
                <div class=" input-group input-group-sm" style="width:120px;">
                    <span class="input-group-text">{{ $t('number_of_lines') }}:</span>
                    <input class="form-control" type="text" style="" disabled placeholder="" value="1024" />
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

        <div class="row mb-2 row-cols-2" style="">
            <div class="col grid-view-y-2 " style="height: 500px;">

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



            <div class="col border border-1 overflow-y-auto" style="height: 500px;">
                <div class="border border-2 border-dark text-md-start">
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('start_time') }} :<span>{{ result.during.start }}</span>
                        </div>
                        <div class="col">
                            {{ $t('total_time_spent') }} :<span>{{ result.during.sec }}</span>
                        </div>
                        <div class="col">
                            {{$t("finish")}}:<span>{{ `${betConfig.nowLoop}/${betConfig.loopNum}` }}</span>
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
                    <h5 class=" fw-bold ">{{ $t('mainGame') }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ $t('mtrp') }} :<span>{{ `${result.data.normal.MRTP}%` }}</span>
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
                            {{ $t('odds_of_winning') }} :<span>{{ roundTo(result.data.normal.nPfCntPnt * 100) }}%</span>
                        </div>
                    </div>

                </div>

                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5 class=" fw-bold ">{{ $t('freeSpin') }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            FRTP :<span>{{ `${result.data.free.RTP}%` }}</span>
                        </div>
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
                    <h5 class=" fw-bold ">{{ $t('detail') }}</h5>
                    <div class=" d-flex flex-row">
                        <div class="table-responsive" style="width: auto;">

                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th>{{ $t("add_level") }}</th>
                                        <th>{{ `${$t("percentage")}(%)` }}</th>
                                        <th style="width: auto;">{{ $t("frequency") }}</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.Hit.times" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ `${roundTo((t[1] / result.hitTimeTotal) * 100)}%` }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive ms-1" style="width: auto;">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th>
                                            {{ $t("number_of_freespin_totems") }}
                                        </th>
                                        <th style="width: auto;">{{ $t("frequency") }}</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.getFree.cnt_times" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="divider-h-1 mb-1"></div>
                    <div class=" d-flex flex-row" style="">
                        <div class="table-responsive" style="width: auto;">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th style="width: auto;">{{ $t("add_level") }}</th>
                                        <th>{{ `${$t("percentage")}(%)` }}</th>
                                        <th>
                                            {{ $t("the_cumulative_number_of_gold_appearances") }}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.gold.Lv_total" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ `${roundTo((t[1] / result.goldLvTotal) * 100)}%` }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive ms-1" style="width: auto;">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th>
                                            {{ $t("number_of_gold_occurrences") }}
                                        </th>
                                        <th style="width: auto;">{{ $t("frequency") }}</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.gold.cnt_times" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="divider-h-1 mb-1"></div>
                    <div class=" d-flex flex-row">
                        <div class="table-responsive" style="width: auto;">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th style="width: auto;">{{ $t("add_level") }}</th>
                                        <th>{{ `${$t("percentage")}(%)` }}</th>
                                        <th>
                                            {{ $t("the_cumulative_number_of_wild_appearances") }}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.wild.Lv_total" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ `${roundTo((t[1] / result.wildLvTotal) * 100)}%` }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                        <div class="table-responsive ms-1" style="width: auto;">
                            <table class="table table-striped table-hover align-middle text-center">
                                <thead class="table-dark">
                                    <tr>
                                        <th>
                                            {{ $t("wild_increase_quantity") }}
                                        </th>
                                        <th style="width: auto;">{{ $t("frequency") }}</th>
                                    </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                    <template v-for="t in result.data.wild.cnt_times" :key="t[0]">
                                        <tr class="table-light">
                                            <td>{{ t[0] }}</td>
                                            <td>{{ t[1] }}</td>
                                        </tr>
                                    </template>

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </div>
</template>

<script setup>
import * as _ from 'lodash'
import { inject, reactive, toRefs, watch, computed } from 'vue'
import { Common, MahJongWays } from '@/config/GameConfig'
import { tryObjToArray, roundTo, numberWithCommas, selectDirFiles, mergeArray } from '@/plugin/Utils'
import * as dll from '@/plugin/native/MahJongWays'
import { ProvideFlag } from '@/config/Enum'
import moment from 'moment'
//import SWorker from 'simple-web-worker'
//import Worker from 'worker-loader!@/views/components/game_MahjongWays/myworker.js'



const log = inject(ProvideFlag.log)

const api = require("@/ElectronApi")

// let props = defineProps({
//     lua: Object,
//     free: Object,
//     parent: Object
// })
// const {  parent } = toRefs(defineProps({
//     parent:Object
// }))

const lua = inject(ProvideFlag.lua)
const parent = inject(ProvideFlag.parent)


let progress = parent.progress
//parent.value.showDialog()
let hd = 100

watch(lua, () => {

    //每次更換設定檔使用初始值
    betConfig.bet.size = tryObjToArray(lua.value.bets.bet).map(v => v / hd).min()
    betConfig.bet.multi = tryObjToArray(lua.value.bets.multi).min()
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
    selectBet: computed({
        get: function () {
            if (!lua.value)
                return []
            return tryObjToArray(lua.value.bets.bet).map(v => v / hd)
        }
    }),
    selectBetMulti: computed({
        get: function () {
            if (!lua.value)
                return []
            return tryObjToArray(lua.value.bets.multi)
        }
    }),
    bet: {
        num: '',//下注總額
        size: 0,
        multi: 0,
        base: computed({
            get: function () {
                if (!lua.value)
                    return 0
                return lua.value.bets.Base
            }
        })
    },
    onBetChange: function () {
        let s = betConfig.bet.size
        let m = betConfig.bet.multi
        let b = betConfig.bet.base
        betConfig.bet.num = s * m * b
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
    objs: computed({
        get: function () {
            if (!lua.value)
                return []

            let d = lua.value.objs.map(o => MahJongWays.DataObj(o))
                .filter(o => {//過濾出有支援的obj
                    if (result.data.tiles[`Obj${o.id}`])
                        return true
                    return false
                })
            console.log(`result objs->${d.jsonString()}`)

            return d

        }
    }),
    hitTimeTotal: computed({
        get: function () {
            return result.data.Hit.times.sum(t => t[1])
        }
    }),
    goldLvTotal: computed({
        get: function () {
            return result.data.gold.Lv_total.sum(t => t[1])
        }
    }),
    wildLvTotal: computed({
        get: function () {
            return result.data.wild.Lv_total.sum(t => t[1])
        }
    }),
    calObjValue: function (id, type = null) {

        let o = result.data.tiles[`Obj${id}`]
        if (!o)
            return { total: 0, ratio: 0 }

        if (type) {
            switch (type) {
                case 'X3':
                    return {
                        total: o[0],
                        ratio: roundTo(o[0] / result.data.TR * 100)
                    }
                case 'X4':
                    return {
                        total: o[1],
                        ratio: roundTo(o[1] / result.data.TR * 100)
                    }
                case 'X5':
                    return {
                        total: o[2],
                        ratio: roundTo(o[2] / result.data.TR * 100)
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
            log: output.log ? output.dirPath : ''
        }
        log.warn({
            msg: `param:${{
                betAmount: Number(config.betNum),
                runTimes: Number(config.round),
                threadNum: Number(config.thread),
                luaPath: config.path,
                luaFolder: config.dir,
                luaLevel: Number(config.luaLv),
                logFolder: config.log
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
    let raw = result.data

    raw.TP = raw.TP.toNum() + n.TP.toNum()
    raw.TR = raw.TP.toNum() + n.TR.toNum()
    raw.TRTP = roundTo((raw.TP / (betConfig.bet.num * betConfig.loopNum)) * 100)

    raw.normal.PfCnt = raw.normal.PfCnt.toNum() + n.normal.PfCnt.toNum()
    raw.normal.TP = raw.normal.TP.toNum() + n.normal.TP.toNum()
    raw.normal.maxPrize = n.normal.maxPrize.toNum() > raw.normal.maxPrize.toNum() ?
        n.normal.maxPrize.toNum() : raw.normal.maxPrize.toNum()
    raw.normal.nPfCntPnt = (raw.normal.PfCnt / betConfig.loopNum)
    raw.normal.MRTP = roundTo((raw.normal.TP / (betConfig.bet.num * betConfig.loopNum)) * 100)

    raw.free.PfCnt = raw.free.PfCnt.toNum() + n.free.PfCnt.toNum()
    raw.free.Rs = raw.free.Rs.toNum() + n.free.Rs.toNum()
    raw.free.TP = raw.free.TP.toNum() + n.free.TP.toNum()
    raw.free.RTP = roundTo((raw.free.TP / (betConfig.bet.num * betConfig.loopNum)) * 100)

    for (const obj in n.tiles) {
        if (raw.tiles[obj].length < 1) {
            raw.tiles[obj] = n.tiles[obj]
        } else {
            raw.tiles[obj][0] = raw.tiles[obj][0] + n.tiles[obj][0]
            raw.tiles[obj][1] = raw.tiles[obj][1] + n.tiles[obj][1]
            raw.tiles[obj][2] = raw.tiles[obj][2] + n.tiles[obj][2]
        }
    }

    for (const key in raw.Hit) {
        raw.Hit[key] = mergeArray(raw.Hit[key], n.Hit[key],
            (l) => l[0],
            (key, v) => [key.toNum(), v.sum(s => s[1])])
    }

    for (const key in raw.getFree) {
        raw.getFree[key] = mergeArray(raw.getFree[key], n.getFree[key],
            (l) => l[0],
            (key, v) => [key.toNum(), v.sum(s => s[1])])
    }

    for (const key in raw.gold) {
        raw.gold[key] = mergeArray(raw.gold[key], n.gold[key],
            (l) => l[0],
            (key, v) => [key.toNum(), v.sum(s => s[1])])
    }
    for (const key in raw.wild) {
        raw.wild[key] = mergeArray(raw.wild[key], n.wild[key],
            (l) => l[0],
            (key, v) => [key.toNum(), v.sum(s => s[1])])
    }
}


function getNewResultData() {
    return {
        "Hit"://加牌level(次)
        {
            "times": [
            ],
            "times_free": [
            ]
        },
        "TP": '',//總收益金額
        "TR": '',//總共跑了幾次(一般下注+freespin)
        "TRTP": '',//總收益率(總收益金額/總下注金額)
        "free":
        {
            "PfCnt": '',//中獎次數
            "RTP": '',
            "Rs": '',//總共跑了幾次freespin
            "TP": '' //freespin總收益金額
        },
        "getFree"://中FreeSpin圖騰數(次)
        {
            "cnt_times": []
        },
        "gold":
        {
            //[加牌level]Gold出現數量累積
            "Lv_total": [],
            //[Gold出現數量](次)
            "cnt_times": []
        },
        "normal":
        {
            "MRTP": '',
            "PfCnt": '',//中獎幾次
            "TP": '',//總收益金額
            "getFT": [],
            "maxPrize": '',
            "nPfCntPnt": '' //一般下注中獎率(中獎幾次/下注次數)
        },
        "tiles":
        {
            "Obj3": [],
            "Obj4": [],
            "Obj5": [],
            "Obj6": [],
            "Obj7": [],
            "Obj8": [],
            "Obj9": [],
            "Obj10": []
        },
        "wild":
        {
            //[加牌level]Wild增加數量累積
            "Lv_total": [],
            //[Wild增加數量](次)
            "cnt_times": []
        },
    }
}


</script>

<style></style>