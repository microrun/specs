package main

import (
	"cuelang.org/go/cue"
	"cuelang.org/go/cue/load"
	"cuelang.org/go/encoding/openapi"
	"github.com/deepmap/oapi-codegen/pkg/codegen"
	"github.com/getkin/kin-openapi/openapi3"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"
	"regexp"
)

const (
	module             = "github.com/microrun/specs/config/v1"
	dir                = "../../config/v1"
	destination        = "../../../specs-go/generated/config/v1/config.go"
	destinationPackage = "v1"
)

func main() {
	cwd, _ := os.Getwd()
	dir := filepath.Join(cwd, dir)

	inst := cue.Build(load.Instances([]string{module}, &load.Config{
		Dir:        dir,
		ModuleRoot: dir,
		Module:     module,
	}))[0]

	if err := inst.Err; err != nil {
		panic(err)
	}

	openApiSchema, err := openapi.Gen(inst, nil)

	if err != nil {
		panic(err)
	}

	goCode, err := generateGoTypes(openApiSchema)

	if err != nil {
		panic(err)
	}

	err = os.MkdirAll(path.Dir(destination), os.ModePerm)

	if err != nil {
		panic(err)
	}

	err = ioutil.WriteFile(destination, []byte(stripComments(goCode)), os.ModePerm)

	if err != nil {
		panic(err)
	}
}

func generateGoTypes(openApiSchema []byte) (string, error) {
	loader := openapi3.NewLoader()
	data, err := loader.LoadFromData(openApiSchema)

	if err != nil {
		return "", err
	}

	return codegen.Generate(data, codegen.Configuration{
		PackageName:   destinationPackage,
		Generate:      codegen.GenerateOptions{Models: true},
		OutputOptions: codegen.OutputOptions{SkipPrune: true},
	})
}

func stripComments(code string) string {
	re := regexp.MustCompile("(?s)//.*?\n|/\\*.*?\\*/")
	stripped := re.ReplaceAllString(code, "")
	return stripped
}
