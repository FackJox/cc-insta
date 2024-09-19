<script>
    import MessageHeader from '../../components/messages/MessageHeader.svelte';
    import MessageList from '../../components/messages/MessageList.svelte';
  </script>
  
  <main>
    <div class="message-page" id="message-page">
      <MessageHeader />
      <input type="search" name="" id="search-msg" placeholder="Search">
      <div class="row-1">
        <div class="col-1">Message</div>
        <div class="col-2">Requests</div>
      </div>
      <MessageList />
    </div>
  </main>
  

     <!-- MessagePage.svelte -->
<style>
    .message-page {
      width: calc(100% - 20px);
      height: 90vh;
      overflow: auto;
      color: black;
      padding: 10px;
      display: block;
    }
  
    #search-msg {
      height: 30px;
      margin: 20px 0;
      padding: 3px 10px;
      width: 100%;
      border-radius: 7px;
      outline: none;
      border: none;
      background-color: rgb(222, 224, 226);
    }
  
    .row-1 {
      display: flex;
      flex-direction: row;
      place-content: space-between;
    }
  
    .row-1 .col-1 {
      font-weight: bold;
    }
  
    .row-1 .col-2 {
      color: rgb(0, 140, 255);
      cursor: pointer;
    }
  </style>
  