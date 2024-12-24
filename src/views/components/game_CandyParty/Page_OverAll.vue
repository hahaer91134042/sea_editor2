<template>
    <div class="container text-start mt-3" style="">
        <div class="over_all_head row align-items-center border mb-3 ">
            <div class="col col-6">
                <div class="input-group">
                    <span class="input-group-text" id="">{{ $t("bet_size") }}</span>
                    <input type="text" v-model="bets.betList" id="bet_lv" class="form-control" placeholder="" />
                    <!-- <div class="input-group-text">
                        <input v-model="bets.isEdit" class="form-check-input" type="checkbox" />
                        <label class="ms-2">新增</label>
                    </div> -->
                </div>
            </div>
            <div class="col col-6">
                <div class="input-group">
                    <span class="input-group-text" id="">{{ $t("bet_multiple") }}</span>
                    <input type="text" v-model="bets.multi" class="form-control" placeholder="" />
                </div>
            </div>
            <div class="row mt-2 ">
                <!-- <div class=" input-group" style="width: 200px;">
                    <span class="input-group-text">{{ $t('basic_bet') }}</span>
                    <input type="text" class="form-control" disabled v-model="bets.base" />
                </div> -->
                <!-- <div class=" input-group " style="width: 200px;">
                    <span class="input-group-text">{{ $t('line_coefficient') }}</span>
                    <input type="number" class="form-control" v-model="bets.lineCoef" />
                </div>
                ({{ $t('explanation_of_line_coefficients') }}) -->
                <div class=" input-group " style="width: 200px;">
                    <span class="input-group-text">{{ $t('bonus_denominator') }}</span>
                    <input type="number" class="form-control" v-model="bets.prizeDen" />
                </div>

            </div>
        </div>
        <div class="over_all_head align-items-center border mb-3 ">
            <div class="input-group w-50 mb-2">
                <span class="input-group-text" id="">JP Denominator</span>
                <input type="number" min="0" class="form-control" placeholder="" v-model="jackpot.total" />

            </div>
            <div class="table-responsive" style="width: 300px;">
                <table class="table table-striped table-hover table-borderless text-center align-middle">
                    <thead class=" table-dark">
                        <tr>
                            <th></th>
                            <th>{{ $t("probability") }}</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        <template v-for="(jp, i) in jackpot.list" :key="i">
                            <tr class="">
                                <td scope="row" >{{`Jackpot ${5-jp.prize_count}`}}</td>
                                <td >
                                    <input style="width: 170px;" type="number" v-model="jp.weight" />
                                </td>
                            </tr>
                        </template>

                    </tbody>
                </table>
            </div>


        </div>

    </div>

</template>
<script setup>
import { inject, reactive, ref, watch, computed } from 'vue'
import { CandyParty } from '@/config/GameConfig'
import { tryObjToArray, tryZero, Log } from '@/plugin/Utils'
import { ProvideFlag } from '@/config/Enum'


const lua = inject(ProvideFlag.lua)
const log = inject(ProvideFlag.log)


let bets = reactive({
    // base: computed({
    //     get: function () {
    //         if (!lua.value) return ''
    //         return lua.value.bets.Base
    //     }
    // }),
    // lineCoef: computed({
    //     get: function () {
    //         if (!lua.value) return ''
    //         return lua.value.line_coef
    //     },
    //     set: function (v) {
    //         if (!lua.value) return
    //         lua.value['line_coef'] = v.toNum()
    //     }
    // }),
    prizeDen: computed({
        get: function () {
            if (!lua.value) return ''
            return lua.value.obj_deno
        },
        set: function (v) {
            if (!lua.value) return
            lua.value['obj_deno'] = v.toNum()
        }
    }),
    isEdit: false,//目前沒用
    betList: computed({
        get: function () {
            // console.log(`over all bet isAdd->${bets.isEdit}`)
            // console.log(`over all bet list data->${lua.value}`)
            if (!lua.value)
                return ''

            return lua.value.bets.join()
        },
        set: function (value) {
            //console.log(`betList set value->${value}`)
            lua.value.bets = value.split(',').map(v => tryZero(v))
        }
    }),
    multi: computed({
        get: function () {
            if (!lua.value)
                return ''

            return lua.value.lines.join()
        },
        set: function (value) {
            lua.value.lines = value.split(',').map(v => tryZero(v))
        }
    })
})

let jackpot = reactive({
    total: computed({
        get: () => lua.value?.jackpot.total ?? 0,
        set: function (v) {
            if (!lua.value) return
            lua.value.jackpot.total = v.toNum()
        }
    }),
    list: computed({
        get: () => lua.value?.jackpot.type ?? []
    })
})


</script>
<style>
.over_all_head {
    margin-left: 0px;

    padding: 10px;

}
</style>