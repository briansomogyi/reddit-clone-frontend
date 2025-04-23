<template>
    <div @click="emitClick">
        <h2>{{ post.title }}</h2>
        <p>{{ post.description }}</p>
    </div>
</template>

<script setup>
defineProps(["post"]);
const emit = defineEmits(["click"]);
const emitClick = () => emit("click", post.id);
</script>