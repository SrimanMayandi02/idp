package main

import (
	"fmt"
	"runtime"
)

// version is overridden by GoReleaser at build time via -ldflags.
var version = "dev"

const banner = `
   ██╗██████╗ ██████╗
   ██║██╔══██╗██╔══██╗
   ██║██║  ██║██████╔╝
   ██║██║  ██║██╔═══╝
   ██║██████╔╝██║
   ╚═╝╚═════╝ ╚═╝
`

const (
	cyan  = "\033[36m"
	dim   = "\033[2m"
	reset = "\033[0m"
)

func main() {
	fmt.Print(cyan + banner + reset)
	fmt.Printf("   %sInternal Developer Platform%s\n", dim, reset)
	fmt.Printf("   %sv%s · %s/%s · github.com/SrimanMayandi02/idp%s\n\n",
		dim, version, runtime.GOOS, runtime.GOARCH, reset)
}
