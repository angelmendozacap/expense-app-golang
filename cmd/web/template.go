package main

import (
	"html/template"
	"io"
	"time"

	"github.com/labstack/echo/v4"
)

type tmpl struct {
	templates *template.Template
}

func (t *tmpl) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

func humanDate(t time.Time) string {
	if t.IsZero() {
		return ""
	}

	return t.UTC().Format("02 Jan 2006 at 15:04")
}

var functions = template.FuncMap{
	"humanDate": humanDate,
	"year":      func() int { return time.Now().UTC().Year() },
}

var newTmpl = &tmpl{
	templates: template.Must(template.New("Expense").Funcs(functions).ParseGlob("./ui/html/*/*.tmpl")),
}
