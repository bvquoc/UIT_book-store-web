import { apiKey } from "@/constants";
import axios from "axios";

export default async function createCategory({ name }: { name: string }) {
  const url = "http://localhost:8080/v1/categories";

  const data = {
    name: name,
  };
  console.log(data);
  const headers = {
    accept: "application/json",
    "Content-Type": "application/json",
    Authorization: apiKey,

    // Add other headers as needed
  };

  // Make a POST request with headers
  const res = axios
    .post(url, data, { headers: headers })
    .then((response) => {
      if (response) return response.data;
    })
    .catch((error) => {
      console.error("Error:", error);
      return error.response.data;
    });
  return res;
}
