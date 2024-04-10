<template>
    <div class="login-container">
        <div class="login-form">
            <p class="titleInfo">请把正脸对准摄像头</p>
            <div class="regInfo">
                <div class="canvas">
                    <!--描绘video截图-->
                    <canvas ref="cav" id="canvas" width="200" height="200" v-show="ishandleClick"></canvas>
                    <!--video用于显示媒体设备的视频流，自动播放-->
                    <video ref="vd" id="video" autoplay playsinline style="width: 200px;height: 200px"></video>
                </div>
            </div>
            <p style="text-align:center;padding:50px 0 0">
                <el-button id="capture" ref="capture" @click='handleClick'>拍照</el-button>
            </p>
        </div>
    </div>

</template>
<script>
import request from "@/utils/request";
const { ElMessage } = require("element-plus");
export default {
    components: {},
    name: 'faceLogin',
    data() {
        return {
            imgUrl: '',
            formData: {},
            vdstate: false,
            ishandleClick: false,
        }
    },
    methods: {
        handleClick() {
            // 1.开启截图
            this.ishandleClick = true;
            let _this = this
            // 2.设备是否可以使用
            if (!_this.vdstate) {
                return false
            }
            // 3.是否已经通过
            if (!_this.states) {
                // 注册拍照按钮的单击事件

                let video = this.$refs['vd']
                let canvas = this.$refs['cav']
                // let form = this.$refs["myForm"];
                let context = canvas.getContext('2d')
                // 绘制画面
                context.drawImage(video, 0, 0, 200, 200)
                let base64Data = canvas.toDataURL('image/jpg')

                // 封装blob对象
                let blob = this.dataURItoBlob(base64Data, 'camera.jpg') // base64 转图片file
                let formData = new FormData()
                formData.append('file', blob)

                this.imgUrl = base64Data
                // 4.人脸检测 && 识别
                request.post("/face/search", formData).then((response) => {
                            console.log(response)
                            if (response.code == 0 && response.data.result == true) {
                                // 验证通过
                                ElMessage({
                                    message: "登陆成功",
                                    type: "success",
                                });
                                // 登陆成功跳转主页
                                window.sessionStorage.setItem("user", JSON.stringify(response.data.user));
                                window.sessionStorage.setItem("identity", JSON.stringify(response.data.identity));
                                // 延迟加载
                                setTimeout(() => {
                                    this.$router.replace({ path: "/home" });
                                    //延迟时间：1秒
                                }, 1000)    
                            } else {
                                ElMessage({
                                    message: response.msg,
                                    type: "error",
                                });
                                // 识别失败，重新截屏
                                this.ishandleClick = false;
                            }
                        }).catch(function (error) {
                            console.log(error)
                        })
            }

        },
        dataURItoBlob(base64Data) {
            var byteString
            if (base64Data.split(',')[0].indexOf('base64') >= 0)
                byteString = atob(base64Data.split(',')[1])
            else byteString = unescape(base64Data.split(',')[1])
            var mimeString = base64Data
                .split(',')[0]
                .split(':')[1]
                .split(';')[0]
            var ia = new Uint8Array(byteString.length)
            for (var i = 0; i < byteString.length; i++) {
                ia[i] = byteString.charCodeAt(i)
            }
            return new Blob([ia], { type: mimeString })
        }
    },
    created() {
        var _this = this
        let a = JSON.stringify(navigator);
        // console.log(this.$route.query.code)
        // this.handlecode()
        this.$nextTick(() => {
            var _this = this
            // console.log('video', this.$refs['vd'])
            // return
            // 访问用户媒体设备的兼容方法
            function getUserMedia(constrains, success, error) {
                var video = _this.$refs['vd'];
                if (navigator.mediaDevices.getUserMedia) {
                    // 最新标准API
                    let myCons = { ...constrains, video: true }
                    navigator.mediaDevices
                        .getUserMedia(constrains)
                        .then((stream) => {
                            video.srcObject = stream
                            video.play();
                            _this.vdstate = true
                        })
                        .catch(error)
                } else if (navigator.webkitGetUserMedia) {
                    // webkit内核浏览器
                    navigator
                        .webkitGetUserMedia(constrains)
                        .then(success)
                        .catch(error)
                } else if (navigator.mozGetUserMedia) {
                    // Firefox浏览器
                    navagator
                        .mozGetUserMedia(constrains)
                        .then(success)
                        .catch(error)
                } else if (navigator.getUserMedia) {
                    // 旧版API
                    navigator
                        .getUserMedia(constrains)
                        .then(success)
                        .catch(error)
                }
            }
            var video = this.$refs['vd']
            var canvas = this.$refs['cav']
            // debugger
            var context = canvas.getContext('2d')

            // 成功的回调函数
            function success(stream) {
                _this.vdstate = true
                // 兼容webkit内核浏览器
                var CompatibleURL = window.URL || window.webkitURL
                // 将视频流设置为video元素的源
                video.src = CompatibleURL.createObjectURL(stream)
                // 播放视频
                video.play()
            }
            // 异常的回调函数
            function error(error) {
                alert(error)
                console.log('访问用户媒体设备失败：', error.name, error.message)
            }
            if (
                navigator.mediaDevices.getUserMedia ||
                navigator.getUserMedia ||
                navigator.webkitGetUserMedia ||
                navigator.mozGetUserMedia
            ) {
                // 调用用户媒体设备，访问摄像头
                getUserMedia(
                    {
                        video: { width: 200, height: 200 }
                    },
                    success,
                    error
                )
            } else {
                alert('你的浏览器不支持访问用户媒体设备')
            }
            // 获取图片
        })
    },
    mounted: function () {
        // setInterval(this.handleClick, 3000)
    },
    // 组件更新
    updated: function () { }
}
</script>


<style rel="stylesheet/scss" lang="scss" scoped>
.regInfo {
    width: 200px;
    height: 200px;
    overflow: hidden;
    border: 1px solid #ccc;
    border-radius: 50%;
    margin: 0 auto;
    position: relative;

    .canvas {
        position: absolute;
        top: 0;
        width: 100%;
    }
}

.titleInfo {
    text-align: center;
    font-weight: 700;
    padding: 30px 0 20px;
}
</style>
     
