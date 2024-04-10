<template>
  <div>

    <div class="login-container">
      <!-- <div style="margin-right: 150px; min-width: 300px">
        <img alt="" src="../../public/login_Team.png" style="width: 600px" />
      </div> -->
      <div style="width: 400px; margin: 150px auto">
        <div>
          <img src="../../public/logo.png" style="width:65px;height:65px;position:absolute;margin-left:9%;" alt="">
        </div>
        <div style="color: white; font-size: 34px;  padding: 10px 0 10px 34%;font-family:SimHei;font-weight:500;">
          学生综合服务管理系统
        </div>
        <el-form ref="form" :model="form" :rules="rules" size="large">
          <el-form-item class="username" prop="username">
            <el-input placeholder="请输入用户名" v-model="form.username" clearable prefix-icon="avatar"></el-input>
          </el-form-item>
          <el-form-item class="password" prop="password">
            <el-input placeholder="请输入密码" v-model="form.password" prefix-icon="lock" show-password></el-input>
          </el-form-item>
          <el-form-item :model="form" class="identity" prop="identity">
            <el-radio v-model="form.identity" label="stu" style="color:#333">学生</el-radio>
            <el-radio v-model="form.identity" label="dormManager" style="color:#333">宿舍管理员</el-radio>
            <el-radio v-model="form.identity" label="admin" style="color:#333">系统管理员</el-radio>
          </el-form-item>
          <el-form-item>
            <el-button :disabled="!disabled"
              style="width: 20%;margin-left:20%;background: linear-gradient(135deg, #6e8efb, #a777e3);" type="primary"
              @click="login">登 录</el-button>
            <el-button style="margin-left:16%;background: linear-gradient(135deg, #6e8efb, #a777e3);" type="primary"
              @click="faceLogin()">人脸识别</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>

    <div class="videoContainer">
      <video class="fullscreenVideo" id="bgVid" playsinline="" autoplay="" muted="" loop="">
        <source src="../assets/video/spa1.mp4" type="video/mp4">
      </video>
    </div>
  </div>
</template>
<script src="@/assets/js/Login.js"></script>

<style scoped>
@import '../assets/css/Login.css';
</style>
<style scoped>
.videoContainer {
  position: fixed;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: -100;
}

.videoContainer:before {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  display: block;
  z-index: -1;
  top: 0;
  left: 0;
  background: rgba(25, 29, 34, .65);
}

video#bgVid {
  width: 100%;
}

.username,
.password {
  width: 80%;
  margin: 6% auto 3%;
}

.identity {
  margin-left: 10%;
}
</style>