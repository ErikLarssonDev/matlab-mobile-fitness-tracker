
function [result,tokens] = openAIChat(content)
    %openAIChat Call openAI REST API for chat completions
    %   Detailed explanation goes here
    tic
    import matlab.net.*
    import matlab.net.http.*
    % Define the API endpoint Davinci
    api_endpoint = "https://api.openai.com/v1/chat/completions";
    % Define the API key from https://beta.openai.com/account/api-keys
    api_key = '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';
    data = jsondecode('{"model":"gpt-3.5-turbo","messages":[{"role":"system","content":"You are a helpful assistant."},{"role":"user","content":"What is my birthday?"}]}');
    data.messages(2).content = content;
    % Define the headers for the API request
    %headers = matlab.net.http.HeaderField('Content-Type', 'application/json');
    %headers(2) = matlab.net.http.HeaderField('Authorization', 'Bearer ' + api_key);
    headers = matlab.net.http.HeaderField('Authorization', ['Bearer ' api_key], ...
                                          'Content-Type', 'application/json');
    % Define the request message
    request = matlab.net.http.RequestMessage('post',headers,data);
    % Send the request and store the response
    response = send(request, URI(api_endpoint));
    % Extract the response text'
    result = response.Body.Data.choices.message.content;
    tokens = response.Body.Data.usage;
    disp(result);
end

