<main>
    <div class="loader" id="loader">
      <img src="icons/favicon.png" width="70" alt="" />
      <div class="branding">
        from <br /> <img src="icons/from-meta.png" width="150px" alt="" />
      </div>
    </div>
  </main>
  
  <style>
    .loader {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
  
    .loader .branding {
      margin-top: 20px;
      color: rgb(66, 66, 66);
      text-align: center;
      font-weight: 500;
    }
  </style>