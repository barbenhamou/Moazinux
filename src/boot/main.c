int main() {
    unsigned short* video_memory = (unsigned short*)0xb8000;
    *video_memory = 0x5f4f;
    return 0;
}