package main

import (
	"context"
	"fmt"
	"os"

	slack "github.com/ashwanthkumar/slack-go-webhook"
	"github.com/aws/aws-lambda-go/lambda"
)

func sendSlackUser(text string, channel string) {
	webhookUrl := "https://hooks.slack.com/services/...."

	payload := slack.Payload{
		Text:      text,
		Username:  "EMR",
		IconEmoji: ":warning:",
		Channel:   channel,
	}
	err := slack.Send(webhookUrl, "", payload)
	if len(err) > 0 {
		fmt.Printf("error: %s\n", err)
	}

}

type Message struct {
	Message string `json:"message"`
}

func LambdaHandler(ctx context.Context, event Message) {
	var channel string
	var text2user string
	channel = os.Getenv("CHANNEL")
	//text2user := "There was an error in EMR  Step Function"
	text2user, exists := os.LookupEnv("MESSAGE")
	if !exists {
		text2user = event.Message

	}

	sendSlackUser(text2user, channel)

}
func main() {

	lambda.Start(LambdaHandler)

}
