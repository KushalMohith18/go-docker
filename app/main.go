package main

import (
	"fmt"
	"net/http"
)

// Large global variable to make compilation expensive
var BigArray [10_000_000]int

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello from Go – cache test")
	})

	fmt.Println("Server running on :8080")
	http.ListenAndServe(":8080", nil)
}
