<template >
    <beautiful-chat :participants="participants" :titleImageUrl="titleImageUrl" :onMessageWasSent="onMessageWasSent"
        :messageList="messageList" :newMessagesCount="newMessagesCount" :isOpen="isChatOpen" :close="closeChat"
        :icons="icons" :open="openChat" :showEmoji="true" :showFile="false" :showEdition="true" :showDeletion="true"
        :deletionConfirmation="true" :showTypingIndicator="showTypingIndicator" :showLauncher="true" :showCloseButton="true"
        :colors="colors" :alwaysScrollToBottom="alwaysScrollToBottom" placeholder="请输入内容！" :disableUserListToggle="false"
        :messageStyling="messageStyling" @onType="handleOnType" @edit="editMessage">
        <template v-slot:header>
            AI太小理
        </template>
    </beautiful-chat>
</template>

<script>
import request from "@/utils/request";
export default {
    name: 'chatAI',
    data() {
        return {
            participants: [
                {
                    id: 'ai',
                    name: '太小理心理咨询师',
                    imageUrl: 'https://img-blog.csdnimg.cn/08e7e2521c02473e8e917030239d16d1.png'
                },
                {
                    id: 'me',
                    name: '用户',
                    imageUrl: 'https://img-blog.csdnimg.cn/08e7e2521c02473e8e917030239d16d1.png'
                }
            ], // the list of all the participant of the conversation. `name` is the user name, `id` is used to establish the author of a message, `imageUrl` is supposed to be the user avatar.
            titleImageUrl: '../assests/logo.png',
            messageList: [
                { type: 'text', author: `ai`, data: { text: `您好，我是AI太小理，您可以向我提供有关心理健康的问题（如我现在学习压力有点大，如何缓解自己的压力），很开心能够为您解答！` } }
            ], // the list of the messages to show, can be paginated and adjusted dynamically
            newMessagesCount: 1,
            isChatOpen: false, // to determine whether the chat window should be open or closed
            showTypingIndicator: '', // when set to a value matching the participant.id it shows the typing indicator for the specific user
            colors: {
                header: {
                    bg: '#4e8cff',
                    text: '#ffffff'
                },
                launcher: {
                    bg: '#4e8cff'
                },
                messageList: {
                    bg: '#ffffff'
                },
                sentMessage: {
                    bg: '#4e8cff',
                    text: '#ffffff'
                },
                receivedMessage: {
                    bg: '#eaeaea',
                    text: '#222222'
                },
                userInput: {
                    bg: '#f4f7f9',
                    text: '#565867'
                }
            }, // specifies the color scheme for the component
            alwaysScrollToBottom: false, // when set to true always scrolls the chat to the bottom when new events are in (new message, user starts typing...)
            messageStyling: true, // enables *bold* /emph/ _underline_ and such (more info at github.com/mattezza/msgdown)
        }
    },
    created() {

    },
    methods: {
        sendMessage(text) {
            if (text.length > 0) {
                this.newMessagesCount = this.isChatOpen ? this.newMessagesCount : this.newMessagesCount + 1
                this.messageList = [...this.messageList, { author: 'ai', type: 'text', data: { text } }]
                // this.onMessageWasSent({ author: 'ai', type: 'text', data: { text } })
            }
        },
        // 发送消息
        onMessageWasSent(message) {
            // called when the user sends a message
            this.messageList = [...this.messageList, message]
            // 禁用输入框
            // 向后端发送消息
            if (message.data.text == undefined || message.data.text == "") {

            } else {
                console.log("输入框的消息：", message.data.text)
                request.post("/sendMsg", message.data.text).then((res) => {
                    if (res.code === "0") {
                        console.log("接收到后端的消息：", res.data)
                        this.sendMessage(res.data)
                        // 取消禁用输入框
                    }
                });
            }
        },
        openChat() {
            // called when the user clicks on the fab button to open the chat
            this.isChatOpen = true
            this.newMessagesCount = 0
        },
        closeChat() {
            // called when the user clicks on the botton to close the chat
            this.isChatOpen = false
        },
        handleScrollToTop() {
            // called when the user scrolls message list to top
            // leverage pagination for loading another page of messages
        },
        handleOnType() {

        },
        editMessage(message) {
            const m = this.messageList.find(m => m.id === message.id);
            m.isEdited = true;
            m.data.text = message.data.text;
        }
    }
}
</script>

<style scoped>
</style>>
