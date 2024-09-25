<main>
    <div class="search-page" id="search-page">
        <div class="search-container">
            <input
                type="search"
                name="searchbar"
                id="search"
                placeholder="Search"
                onfocus="explore.style.display='none'"
                onblur="explore.style.display='block'"
            />
        </div>
        <div class="explore" id="explore">
            <div class="row">
                <img src="assets/abp.jpg" alt="" />
                <img src="assets/krish.jpg" alt="" />
                <img src="assets/aditya.jpg" alt="" />
            </div>
            <div class="row">
                <img src="assets/akash.webp" alt="" />
                <img src="assets/jay.jpg" alt="" />
                <img src="assets/unknown-profile.png" alt="" />
            </div>
            <div class="row">
                <img src="assets/tripripost.jpg" alt="" />
                <img src="assets/travel.jpg" alt="" />
                <img src="assets/tripti.jpg" alt="" />
            </div>
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
    .search-page .explore .row img {
        width: 32%;
        object-fit: cover;
    }
</style>