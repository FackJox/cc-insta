<script>
    import Loader from "../components/Loader.svelte";
    import { onMount } from "svelte";
    import Navigations from "../components/Navigations.svelte";

    let loading = true;

    onMount(() => {
        loading = false;
    });
</script>

{#if loading}
    <Loader />
{/if}

<slot />

<div class="navigations-div">
    <Navigations />
</div>

<style>
    .navigations-div {
        width: 100%;
        height: 40px;
        background-color: rgb(255, 255, 255);
        position: sticky;
        bottom: 0px;
    }
</style>
