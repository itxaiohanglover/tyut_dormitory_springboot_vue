import {createApp} from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './assets/css/global.css'
// element-plus
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ELIcons from '@element-plus/icons-vue'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import Chat from 'vue3-beautiful-chat'

const app = createApp(App)
    .use(ElementPlus, {
        locale: zhCn
    })

for (let iconName in ELIcons) {
    app.component(iconName, ELIcons[iconName])
}
app.use(router)
app.use(store)
app.use(Chat)

app.mount('#app')

