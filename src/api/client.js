import axios from 'axios';

const API_BASE = import.meta.env.VITE_API_URL || 'http://localhost:8002';

const client = axios.create({
  baseURL: API_BASE,
  headers: {
    'Content-Type': 'application/json',
  },
});

export async function submitContact(data) {
  const response = await client.post('/api/contacts/', data);
  return response.data;
}

export default client;