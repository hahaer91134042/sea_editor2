<template>
    <div class=" container p-2 ">
        <div class="row mb-2 align-items-center">
            <div class="col col-1" style="">
                <span class="" style="height: 35px;">LOOP:</span>
            </div>

            <div class="col col-7" style="">
                <div class=" input-group  input-group-sm">
                    <input class=" form-control" style="width: 50px;" type="number" v-model="betConfig.loopNum"
                        :placeholder="Lang.tc.number_of_entries" />
                    <select class="form-select" v-model="betConfig.selectLoop" @change="betConfig.onChangeLoop()">
                        <template v-for="(v, i) in betConfig.loop" :key="i">
                            <option :value="v">{{ numberWithCommas(v) }}</option>
                        </template>
                    </select>
                    <span class=" input-group-text ">{{ Lang.tc.thread }}:</span>
                    <select class="form-select" v-model="betConfig.threadNum">

                        <template v-for="(o, i) in Common.thread.nums" :key="i">
                            <option :value="o">x {{ o }}</option>
                        </template>

                    </select>
                    <span class=" input-group-text ">{{ Lang.tc.mode_of_operation }}:</span>
                    <select class="form-select" v-model="betConfig.mode">
                        <option selected value="0">{{ Lang.tc.single_gear }}</option>
                        <option value="1">{{ Lang.tc.reality }}</option>
                    </select>
                    <input v-show="betConfig.mode == 1" v-model="betConfig.realityPath"
                        @click="betConfig.onSelectRealityDir()" class="form-control " placeholder="選擇真實路徑"
                        style="width: 50px;" readonly v-tooltip :title="betConfig.realityPath"
                        data-bs-placement="bottom" />
                </div>

            </div>
            <div class="col" style="">
                <div class=" input-group input-group-sm" style="width:120px;">
                    <span class="input-group-text">{{ Lang.tc.number_of_lines }}:</span>
                    <input class="form-control" type="text" style="" disabled placeholder="" value="243" />
                </div>
            </div>

        </div>
        <div class="row mb-2 row-cols-auto align-items-center" style="width:100%;">

            <div class="col col-6">
                <div class="input-group ">

                    <select class="form-select" v-model="betConfig.bet.size" @change="betConfig.onBetChange()">
                        <option disabled value="0">{{ Lang.tc.place_bet }}</option>

                        <template v-for="(v, i) in betConfig.selectBet" :key="i">
                            <option :value="v">{{ v }}</option>
                        </template>
                    </select>
                    <span class="input-group-text">x</span>
                    <select class="form-select" v-model="betConfig.bet.multi" @change="betConfig.onBetChange()">
                        <option disabled value="0">{{ Lang.tc.multiply }}</option>

                        <template v-for="(v, i) in betConfig.selectBetMulti" :key="i">
                            <option :value="v">{{ v }}</option>
                        </template>
                    </select>
                    <span class="input-group-text">x {{ betConfig.bet.base }}</span>
                    <span class="input-group-text">=</span>
                    <input type="text" class="form-control" :placeholder="Lang.tc.bet_amount" readonly
                        v-model="betConfig.bet.num" />
                </div>

            </div>

            <div class="col col-4" style="">
                <!-- checkbox -->
                <div class="input-group">
                    <div class="input-group-text">
                        <input class="form-check-input mt-0" type="checkbox" v-model="output.log" value="" />
                        <label>{{ Lang.tc.output_log }}</label>
                    </div>
                    <input type="text" class="form-control" v-model="output.dirPath" v-tooltip :title="output.dirPath"
                        data-bs-placement="bottom" />
                    <button class="btn btn-outline-secondary" style="width:50px;"
                        v-on:click="output.onSelectDir()">...</button>
                </div>
            </div>
            <div class="col" style="">
                <div class="input-group ">
                    <button class="btn btn-outline-secondary" @click="result.runTest()" style="width:100px;"
                        type="button" id="">
                        {{ Lang.tc.start_calculation }}
                    </button>

                </div>
            </div>
        </div>

        <div class="row mb-2 row-cols-2" style="">
            <div class="col grid-view-y-2 " style="height: 500px;">

                <template v-for="o in result.objs" :key="o.id">
                    <div class="card" style="height:250px;">
                        <div class="card-header">
                            <span>{{ o.name }} </span>
                            <label>({{ result.calObjValue(o.id).ratio }}%)</label>
                        </div>
                        <div class="card-body table-responsive">
                            <table class="table " style="font-size:x-small;">
                                <tbody>
                                    <template v-for="(c, i) in o.content" :key="i">
                                        <tr class="">
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



            <div class="col border border-1" style="">
                <div class="border border-2 border-dark text-md-start">
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ Lang.tc.start_time }} :<span>{{ result.during.start }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.total_time_spent }} :<span>{{ result.during.sec }}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            {{ Lang.tc.total_revenue }} :<span>{{ result.data.TP }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.trtp }} :<span>{{ result.data.TRTP }}%</span>
                        </div>
                        <div class="col"></div>
                    </div>
                </div>

                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5>{{ Lang.tc.mainGame }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ Lang.tc.mtrp }} :<span>{{ result.data.normal.MRTP }}%</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.total_revenue }} :<span>{{ result.data.normal.TP }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.tax_amount }} :<span>0</span>
                        </div>
                    </div>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ Lang.tc.highest_profit_in_a_single }} :<span>{{ result.data.normal.maxPrize }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.number_of_times_won }} :<span>{{ result.data.normal.PfCnt }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.odds_of_winning }} :<span>{{ roundTo(result.data.normal.nPfCntPnt * 100)
                                }}%</span>
                        </div>
                    </div>

                </div>

                <div class="border border-2 border-dark text-md-start mt-2 p-0">
                    <h5>{{ Lang.tc.freeSpin }}</h5>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ Lang.tc.number_of_times_won }} :<span>{{ result.data.free.PfCnt }}</span>
                        </div>
                        <div class="col">
                            {{ Lang.tc.total }} :<span>{{ result.data.free.Rs }}</span>{{ Lang.tc.round }}
                        </div>
                    </div>
                    <div class="row row-cols-auto">
                        <div class="col">
                            {{ Lang.tc.total_revenue }} :<span>{{ result.data.free.TP }}</span>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </div>
</template>

<script setup>
import { inject, reactive, toRefs, watch, computed } from 'vue'
import { Common, MahJongWays } from '@/config/GameConfig'
import { Lang } from '@/config/Lang'
import { tryObjToArray, roundTo, numberWithCommas } from '@/plugin/Utils'
import * as dll from '@/plugin/native/MahJongWays'
import moment from 'moment'



const api = require("@/ElectronApi")

// let props = defineProps({
//     lua: Object,
//     free: Object,
//     parent: Object
// })
// const {  parent } = toRefs(defineProps({
//     parent:Object
// }))

const lua = inject('lua')
const parent = inject('parent')


let progress = parent.progress
//parent.value.showDialog()

watch(lua, () => {

    //每次更換設定檔使用初始值
    betConfig.bet.size = tryObjToArray(lua.value.bets.bet).min()
    betConfig.bet.multi = tryObjToArray(lua.value.bets.multi).min()
    betConfig.onBetChange()
})

let betConfig = reactive({
    loopNum: 10000,
    selectLoop: 10000,
    loop: [1, 10, 100, 1000, 10000, 20000, 100000, 1000000],
    onChangeLoop: () => betConfig.loopNum = betConfig.selectLoop,
    mode: '0',//運作方式 0:單檔 1:真實
    threadNum: Common.thread.def,
    realityPath: '',
    selectBet: computed({
        get: function () {
            if (!lua.value)
                return []
            return tryObjToArray(lua.value.bets.bet)
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
                console.log('selected directory:' + res.filePaths[0]);
                betConfig.realityPath = res.filePaths[0]
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
            });
    }
})



let result = reactive({
    during: {
        start: '',
        sec: ''
    },
    data: {
        "TP": '',
        "TR": '',
        "TRTP": '',
        "free":
        {
            "PfCnt": '',
            "Rs": '',
            "TP": ''
        },
        "normal":
        {
            "MRTP": '',
            "PfCnt": '',
            "TP": '',
            "getFT": [],
            "maxPrize": '',
            "nPfCntPnt": ''
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
        }
    },
    objs: computed({
        get: function () {
            if (!lua.value)
                return []

            let d = lua.value.objs.map(o => MahJongWays.DataObj(o))
            //console.log(`result objs->${d.jsonString()}`)
            return d

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
            parent.showDialog({ msg: '請先輸入投注額' })
            return
        }


        if (betConfig.loopNum < 1) {
            parent.showDialog({ msg: '請先輸入回合數' })
            return
        }


        parent.saveLua()

        let start = moment()

        progress.show(() => {
            dll.calResult({
                betNum: betConfig.bet.num,
                round: betConfig.loopNum,
                thread: betConfig.threadNum,
                path: betConfig.mode == 0 ? parent.getLoadFilePath() : '',
                dir: betConfig.mode == 1 ? betConfig.realityPath : '',
                log: output.log ? output.dirPath : ''
            }).then(res => {
                console.log(`run result->${res.jsonString()}`)
                progress.hide()

                result.data = res
                let end = moment()

                result.during.start = start.format(Common.format.fullTime)
                result.during.sec = `${end.diff(start, 'milliseconds') / 1000}秒`
            })
        })



    }

})




</script>

<style></style>