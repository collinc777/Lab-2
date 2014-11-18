typedef struct ELE {
    int val;
    struct ELE *next;
} *list_ptr;

int main(){
	
}

int copy_block(int *src, int *dest, int len)
{
    int result = 0;
    int val    = 0;
    while (len > 0) {
	val = *src++;
	*dest++ = val;
	result ^= val;
	len--;
    }
    return result;
}