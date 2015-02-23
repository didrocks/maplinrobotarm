// Web
package main

import (
	"fmt"
	"github.com/go-martini/martini"
	"net/http"
)

func main() {
	m := martini.Classic()
	static := martini.Static("web", martini.StaticOptions{Fallback: "/index.html", Exclude: "/api/v"})
	m.NotFound(static, http.NotFound)
	fmt.Println("Listening on 3000")
	m.Run()
}
