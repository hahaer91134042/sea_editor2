import router from '@/router';


//const router=useRouter()

const Page={
    
    goHome(){
        router.push('/')
    },
    goSetting(){
        //console.log(`Page router`)
        //console.log(router)
        router.push('/setting')
    }
}


export {
    Page
}