import { defineStore } from "pinia";

export const usePostStore = defineStore("post", {
    state: () => ({
        posts: [],
    }),
    actions: {
        async fetchPosts() {
            const response = await axios.get("http://localhost:5000/posts");
            this.posts = response.data;
        },
    },
});
