<template>
    <div class="p-1">
        <div class="card" style="width: 750px;" id="main_card_1">
            <div class=" card-body ">
                <div class=" card-title" style="text-align: start;">
                    <span class="fs-4">
                        {{ $t("cornucopia") }}
                    </span>
                </div>
                <div class="mt-1 d-flex flex-row">
                    <div class="input-group " style="width:200px;">
                        <span class="input-group-text">{{ $t("denominator") }}:</span>
                        <input type="number" min="0" class="form-control" v-model="bonus.deno" />
                    </div>
                    <div class="input-group ms-2" style="width:250px;">
                        <span class="input-group-text">{{ $t("default_game_count") }}:</span>
                        <input type="number" min="0" class="form-control" v-model="bonus.gameCount" />
                    </div>
                </div>

                <div class="mt-3 d-flex flex-column align-items-start">
                    <button type="button" class="btn btn-outline-dark p-0" style="width: 50px;height: 30px;"
                        @click="bonus.addProp()">
                        <fa-icon :icon="['fas', 'plus']" />
                    </button>
                    <div class=" overflow-y-auto " style="height: 350px;">

                        <table class="table table-striped table-hover  align-middle" style="">
                            <thead class="">
                                <tr>
                                    <th style="width: 30px;">ID</th>
                                    <th style="width: 100px;">{{ $t("weight") }}</th>
                                    <th style="width: 100px;">{{ $t("basic_score_low") }}</th>
                                    <th style="width: 100px;">{{ $t("basic_score_high") }}</th>
                                    <th style="width: 100px;">N</th>
                                    <th style="width: 100px;">X</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <template v-for="(p, i) in  bonus.props " :key="i">
                                    <tr class="" :id="`row${i}_${p.id}`">
                                        <td scope="row">{{ p.id }}</td>
                                        <td>
                                            <input class=" form-control" type="number" min="0" v-model="p.factor" />
                                        </td>
                                        <td>
                                            <input class=" form-control" type="number" min="0" v-model="p.base_min" />
                                        </td>
                                        <td>
                                            <input class=" form-control" type="number" min="0" v-model="p.base_max" />
                                        </td>
                                        <td>
                                            <input class=" form-control" type="number" min="0" v-model="p.n" />
                                        </td>
                                        <td>
                                            <input class=" form-control" type="number" min="0" v-model="p.x" />

                                        </td>
                                    </tr>
                                    <MouseMenu :domId="`row${i}_${p.id}`" :menus="bonus.getMouseMenuItem(p)">

                                    </MouseMenu>
                                </template>


                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="input-group mt-2">
                    <span class="input-group-text">{{ $t("formula") }}:</span>
                    <span class="input-group-text fs-7">{{ `tc * ${$t("basic_score")} / ${$t("denominator")};
                        { tc=(totalbet - totalwin) * N + (totalbet / ${$t("denominator")})* X, totalbet - totalwin
                        < 0${$t("pick")}0}` }}</span>
                </div>


            </div>

        </div>
    </div>
</template>
<script setup>
import { inject, reactive, ref, watch, computed } from 'vue'
import { CandyParty } from '@/config/GameConfig'
import { Log } from '@/plugin/Utils'
import { ProvideFlag } from '@/config/Enum'
import MouseMenu from '../MouseMenu.vue'

const lua = inject(ProvideFlag.lua)

let bonus = reactive({
    deno: computed({
        get: () => lua?.value?.bonus.deno ?? 0,
        set: (v) => {
            if (!lua.value)
                return
            lua.value.bonus.deno = Number(v)
        }
    }),
    gameCount: computed({
        get: () => lua?.value?.bonus.docount ?? 0,
        set: (v) => {
            if (!lua.value)
                return
            lua.value.bonus.docount = Number(v)
        }
    }),
    props: computed({
        get: () => lua?.value?.bonus.propertys ?? []
    }),
    addProp() {
        if (!lua.value)
            return
        lua.value.bonus.propertys.push({
            id: lua.value.bonus.propertys.length+1,
            factor: 0,
            base_min: 0,
            base_max: 0,
            n: 0,
            x: 0,
        })

    },
    getMouseMenuItem(p) {
        return [{
            label: window.$t("delete"),
            //tip: 'Alt+向左箭头',
            click: () => {
                //console.log(`right click prop->${p.jsonString()}`)
                lua.value.bonus.propertys.remove(p1 => p1.id == p.id)
                //console.log(`bonus prop change->${lua.value.bonus.propertys.jsonString()}`)
                for (let i = 0; i < lua.value.bonus.propertys.length; i++) {
                    lua.value.bonus.propertys[i].id = i + 1
                }
            }
        }]
    }
})




// function showDelete(p, event) {
//     console.log(`right click prop->${p.jsonString()} event->${event}`)
//     console.log(event)
// }


</script>
<style></style>