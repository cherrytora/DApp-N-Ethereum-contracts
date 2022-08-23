import React from "react";

export function MintWTML({ mintWTML }) { 
  // 建立mintNFT這個function，把在前端的入的to傳到Dapp.js中
  return (
    <div>
      <h4>MintWTML</h4> 
      <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();

          const formData = new FormData(event.target);
          const to = formData.get("to");
          const tokenURI = formData.get("tokenURI");


          if (to && tokenURI) {
            mintWTML(to, tokenURI);
          }
        }}
      >
        <div className="form-group">
          <label>WTML Mint address</label>
          <input className="form-control" type="text" name="to" required />
          <label>WTML Mint URI</label>
          <input className="form-control" type="text" name="tokenURI" required />
        </div>
        <div className="form-group">
          <input className="btn btn-primary" type="submit" value="mintWTML" />
        </div>
      </form>
    </div>
  );
}