package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)


func main(){

	http.HandleFunc("/",handleRequest)

	fmt.Printf("server is listening in port 8080 \n")
	
	http.ListenAndServe(":8080",nil)
}

func handleRequest(response http.ResponseWriter, request *http.Request){

	if request.Method ==  "GET" {

		response.Header().Add("Content-type","application/json")
		response.WriteHeader(200)

		json.NewEncoder(response).Encode("{healthy: true}")

	}else{
		response.Header().Add("Content-type","application/json")
		response.WriteHeader(400)
	}
}