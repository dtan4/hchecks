package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestMain(t *testing.T) {
	ts := httptest.NewServer(http.HandlerFunc(Handler))
	defer ts.Close()

	r, err := http.Get(ts.URL)

	if err != nil {
		t.Fatalf("Failed to process GET request: %v", err)
	}

	data, err := ioutil.ReadAll(r.Body)

	if err != nil {
		t.Fatalf("Failed to read response body: %v", err)
	}

	defer r.Body.Close()

	expected := "I am healthy.\n"

	if expected != string(data) {
		t.Fatalf("Body is invalid. expected: %q actual: %q", expected, string(data))
	}
}
