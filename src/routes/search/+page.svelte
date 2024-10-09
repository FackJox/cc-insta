<script>
    import { feedCharacters } from '$lib/feedCharacters.js';
    import { mainCharacters } from '$lib/mainCharacters.js';
    import { onMount } from 'svelte';

    let allCharacters = [...feedCharacters, ...mainCharacters];
    let displayedImages = [];
    let searchTerm = '';

    function getRandomImages(count) {
        let allImages = allCharacters.flatMap(char => char.postImages);
        let shuffled = allImages.sort(() => 0.5 - Math.random());
        return shuffled.slice(0, count);
    }

    function searchImages() {
        if (searchTerm.trim() === '') {
            displayedImages = getRandomImages(12);
        } else {
            let filteredImages = allCharacters.flatMap(char => 
                char.postImages.filter(img => 
                    img.toLowerCase().includes(searchTerm.toLowerCase())
                )
            );
            displayedImages = filteredImages.slice(0, 12);
        }
    }

    onMount(() => {
        displayedImages = getRandomImages(12);
    });
</script>

<main>
    <div class="search-page" id="search-page">
        <div class="search-container">
            <input
                type="search"
                name="searchbar"
                id="search"
                placeholder="Search"
                bind:value={searchTerm}
                on:input={searchImages}
            />
        </div>
        <div class="explore" id="explore">
            {#each Array(4) as _, rowIndex}
                <div class="row">
                    {#each Array(3) as _, colIndex}
                        {#if displayedImages[rowIndex * 3 + colIndex]}
                            <img src={displayedImages[rowIndex * 3 + colIndex]} alt="" />
                        {:else}
                            <div class="empty-image"></div>
                        {/if}
                    {/each}
                </div>
            {/each}
        </div>
    </div>
</main>

<style>
    /* search page */
    .search-page {
        width: 100%;
        height: 90vh;
        overflow-y: auto;
        color: black;
        display: flex;
        flex-direction: column;
    }
    .search-container {
        position: sticky;
        top: 0;
        background-color: white;
        padding: 10px;
        z-index: 1;
    }
    .search-page #search {
        width: 100%;
        height: 30px;
        padding: 5px 10px;
        border: none;
        outline: none;
        border-radius: 5px;
        background-color: rgb(226, 228, 230);
    }
    .search-page .explore {
        display: flex;
        flex-direction: column;
        gap: 2px;
        padding: 10px;
    }
    .search-page .explore .row {
        display: flex;
        justify-content: space-between;
        gap: 2px;
        margin-bottom: 2px;
    }
    .search-page .explore .row img, .search-page .explore .row .empty-image {
        width: 32%;
        aspect-ratio: 1 / 1;
        object-fit: cover;
    }
    .empty-image {
        background-color: #f0f0f0;
    }
</style>