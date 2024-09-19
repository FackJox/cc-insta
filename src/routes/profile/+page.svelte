     <main>
         <!-- profile Page -->
      <div class="profile-page" id="profile-page">
        <div class="header">
            <label for="name">krushnasahane7</label>
        </div>
        <div class="profile-box">
            <div class="row-1">
                <div class="col"><img src="assets/krish.jpg" alt="" width="80px"></div>
                <div class="col"><b>1</b> <label>Posts</label></div>
                <div class="col"><b>406</b><label>Followers</label></div>
                <div class="col"><b>548</b><label>Following</label></div>
            </div>
            <div class="row-2">
                <label for="name">KRUSHNA SAHANE</label>
                <label for="second insta id">@code_with_krish_</label>
            </div>
            <div class="row-3">
                <button>Edit profile</button>
                <button>Share profile</button>
            </div>
        </div>
        <div class="highlights">
            <div><img src="assets/avcoe.jpg" alt="" width="60px" height="60px">
                <label for="myself">AVCOE</label>
            </div>
            <div><img src="assets/krish.jpg" alt="" width="60px" height="60px">
                <label for="myself">MySelf</label>
            </div>
            <div><img src="assets/travel.jpg" alt="" width="60px" height="60px">
                <label for="myself">Travel Life</label>
            </div>
            <div><img src="assets/farmer.jpg" alt="" width="60px" height="60px">
                <label for="myself">Shetkari</label>
            </div>
            <div><img src="assets/holi.jpg" alt="" width="60px" height="60px">
                <label for="myself">Holi 2K22</label>
            </div>
        </div>
        <section class="post-reels">
            <div class="row-1">
                <img src="icons/grid.png" alt="" width="25px">
                <img src="icons/reel.webp" alt="" width="30px">
                <img src="icons/tag.png" alt="" width="35px">
            </div>
            <div class="row-2">
                <img src="assets/krish.jpg" alt="" width="33%">
            </div>
        </section>
    </div>
    <!-- End of the profile Page -->


     </main>
<style>

    
.profile-page{
    width: calc(100% - 20px);
    height: 90vh;
    overflow: auto;
    color: black;
    padding: 10px;
    display: block;
}
.profile-page .profile-box .row-1{
    margin-top: 30px;
    display: flex;
    flex-direction: row;
    place-content: space-between;
    align-items: center;
}
.profile-page .row-1 .col{
    display: flex;
    flex-direction: column;
    align-items: center;
}
.profile-page .profile-box .row-1 .col:nth-child(1) img{
    border-radius: 50%;
}
.profile-page .profile-box .row-2{
    display: flex;
    flex-direction: column;
}
.profile-page .profile-box .row-2 label:nth-child(1){
    font-weight: bold;
    color: rgb(46, 46, 46);
}
.profile-page .profile-box .row-2 label:nth-child(2){
    color: rgb(9, 9, 41);
}
.profile-page .profile-box .row-3{
    display: flex;
    flex-direction: row;
    place-content: space-between;
    margin-top: 20px;
}
.profile-page .profile-box .row-3 button{
    width: 45%;
    padding: 5px;
    border: none;
    outline: none;
    border-radius: 5px;
    font-weight: bold;
    color: rgb(44, 44, 44);
}

.profile-page .highlights{
    margin-top: 20px;
    display: flex;
    flex-direction: row;
    overflow-y: scroll;
    align-items: center;
    gap: 20px;
}
.profile-page .highlights div{
    display: flex;
    flex-direction: column;
    gap: 5px;
    align-items: center;    
    font-size: 10pt;
}
.profile-page .highlights div img{
    border-radius: 50%;
}
.profile-page .post-reels{
    margin-top: 20px;
    height: auto;
    width: 100%;
    overflow-y: scroll;
}
.profile-page .post-reels .row-1{
    width: 100%;
    display: flex;
    flex-direction: row;
    place-content: space-around;
    align-items: center;
}
.profile-page .post-reels .row-2{
    margin-top: 20px;
    width: 100%;
    display: flex;
    flex-direction: row;
    gap: 2px;
}
</style>