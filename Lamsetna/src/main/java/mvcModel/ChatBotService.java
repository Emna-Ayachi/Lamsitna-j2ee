package mvcModel;

import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@Stateless
@LocalBean
public class ChatBotService {

    public String getResponse(String message) throws IOException {

        String apiUrl =
            "https://router.huggingface.co/v1/chat/completions";

        String token = "";
        if (token == null || token.isEmpty()) {
            throw new RuntimeException("HF_TOKEN is missing");
        }

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + token);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");

        conn.setConnectTimeout(10000);
        conn.setReadTimeout(20000);

        conn.setDoOutput(true);

        // safer JSON escaping
        String safeMessage = message.replace("\"", "\\\"");

        String jsonInput = "{"
                + "\"model\":\"Qwen/Qwen2.5-7B-Instruct:together\","
                + "\"messages\":["
                + "{"
                + "\"role\":\"system\","
                + "\"content\":\"You are Lamsetna's assistant. Lamsetna is a civic environmental platform where users can report pollution, create events, join cleanups, and earn badges. Help users navigate the platform, explain features, and encourage participation.\""
                + "},"
                + "{"
                + "\"role\":\"user\","
                + "\"content\":\"" + safeMessage + "\""
                + "}"
                + "]"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes(StandardCharsets.UTF_8));
        }

        int status = conn.getResponseCode();
        InputStream stream = (status >= 200 && status < 300)
                ? conn.getInputStream()
                : conn.getErrorStream();

        BufferedReader br = new BufferedReader(
                new InputStreamReader(stream, StandardCharsets.UTF_8)
        );

        StringBuilder response = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        br.close();

        return response.toString();
    }
}
