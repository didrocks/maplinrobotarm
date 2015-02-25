// Web
package main

import (
	"fmt"
	"github.com/go-martini/martini"
	//"net/http"
	"os"
)

func main() {
	m := martini.Classic()
	dir := "./web"
	if len(os.Args) > 1 {
		dir = os.Args[1]
	}
	fmt.Println("Directory", dir)

	static := martini.Static(dir, martini.StaticOptions{Fallback: "/index.html", Exclude: "/api/v"})
	m.Use(static)
	//m.NotFound(static, http.NotFound)

	fmt.Println("Listening on 3000")
	m.Run()
}
