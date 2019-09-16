function gen_speach()
{

api=$(cat api_t_s)
echo "enter text to send or convert:"

read text
curl -H "Content-Type: application/json; charset=utf-8" \
  --data "{
    'input':{
      'text':'$text'
    },
    'voice':{
      'languageCode':'en-gb',
      'name':'en-GB-Standard-A',
      'ssmlGender':'FEMALE'
    },
    'audioConfig':{
      'audioEncoding':'MP3'
    }
  }" "https://texttospeech.googleapis.com/v1/text:synthesize?key=$api" | grep -oP '(?<=audioContent": ")(.*)(?=")' | base64 --decode > /tmp/1.mp3 

mpg123 /tmp/1.mp3

}

function to_speach()
{

arecord -d 15 -vv -f S16_LE /tmp/recorded.flac 

gcloud ml speech recognize '/tmp/recorded.flac' --language-code='en-IN'


