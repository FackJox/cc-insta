<script>
    import Loader from "../components/Loader.svelte";
    import { onMount } from "svelte";
    import Navigations from "../components/Navigations.svelte";

    let loading = true;

    onMount(() => {
        setTimeout(() => {
            loading = false;
        }, 1000); // 5000 milliseconds = 5 seconds
    });


onMount(() => {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/service-worker.js');
  }
});
</script>

{#if loading}
    <Loader />
{:else}
    <slot />

    <div class="navigations-div">
        <Navigations />
    </div>
{/if}

<style>
    .navigations-div {
        width: 100%;
        height: 40px;
        background-color: rgb(255, 255, 255);
        position: fixed;
        bottom: 0;
        left: 0;
        z-index: 1000;
        padding-bottom: env(safe-area-inset-bottom);
    }
</style>