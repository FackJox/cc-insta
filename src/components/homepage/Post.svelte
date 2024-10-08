<script>
import { goto } from '$app/navigation';

export let profilePic;
export let username;
export let postImage;
export let likedBy;
export let caption;
export let commentCount;

function navigateToProfile(username) {
    goto(`/profile/${username}`);
}
  </script>
  
  <div class="post">
    <div class="row-1">
        <div class="col-1">
            <div class="profile-pic">
                <img src={profilePic} alt="" width="30px" />
            </div>
            <div class="username">
                <b>
                    <a href={`/profile/${username}`} on:click|preventDefault={() => navigateToProfile(username)}>
                        {username}
                    </a>
                </b>
            </div>
        </div>
        <div class="col-2">
            <div class="more">
                <img src="/icons/dots.png" alt="" width="20px" />
            </div>
        </div>
    </div>
    <div class="row-2">
      <img src={postImage} alt="" width="100%" />
    </div>
    <div class="row-3">
      <div class="col-1">
        <img src="/icons/heart.png" alt="" width="25px" />
        <img src="/icons/chat.png" alt="" width="25px" />
        <img src="/icons/share.png" alt="" width="25px" />
      </div>
      <div class="col-2">
        <img src="/icons/ribbon.png" alt="" width="25px" />
      </div>
    </div>
    <div class="row-4">
      Liked by <b>{likedBy}</b> and <b>others</b> <br />
      <b>{username}</b> {caption} <br />
      <span class="comments">
        View all {commentCount} comments <br />
        <div class="profile-pic">
          <img src="/assets/ceci/ceci_01.png" alt="" width="30px" /> Add a comment...
        </div>
      </span>
    </div>
  </div>
  
  <style>

  .post {
    background-color: white;
    border: 1px solid #dbdbdb;
    border-radius: 3px;
    margin-bottom: 20px;
  }
  .row-1 {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
  }
  .row-1 .col-1 {
    display: flex;
    align-items: center;
  }
  .row-1 .col-1 .profile-pic {
    margin-right: 10px;
  }
  .row-1 .col-1 .profile-pic img {
    border-radius: 50%;
  }
  .row-3 {
    display: flex;
    justify-content: space-between;
    padding: 10px;
  }
  .row-3 .col-1 img {
    margin-right: 10px;
  }
  .row-4 {
    padding: 10px;
  }
  .row-4 .comments {
    color: #8e8e8e;
  }

  .username a {
        text-decoration: none;
        color: inherit;
    }

    .username a:hover {
        text-decoration: underline;
    }
</style>  