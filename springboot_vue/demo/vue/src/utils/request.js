import axios from 'axios'

const request = axios.create({
    baseURL: '/api', 
    timeout: 600000
})
let token = '';
// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
//添加一个请求拦截器
axios.interceptors.request.use(function (config) {
    let user = JSON.parse(window.sessionStorage.getItem('access-user'));
    if (user) {
        token = user.token;
    }
    config.headers.common['token'] = token;
    //console.dir(config);
    return config;
}, function (error) {
    // Do something with request error
    console.info("error: ");
    console.info(error);
    return Promise.reject(error);
});

// response 拦截器
// 可以在接口响应后统一处理结果
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果是返回的文件
        if (response.config.responseType === 'blob') {
            return res
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)

// 以request暴露出去
export default request

