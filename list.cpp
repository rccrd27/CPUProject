#include <iostream>
#include <vector>

using namespace std;

typedef struct item{
    int value;
    struct item *next;
} item_t;
     
void initNode(struct item* head, int n){
    head->value = n;
    head->next = NULL;
}

void addNode(struct item *&head, int n){
    struct item *temp = new item;
 temp-> value = n;
 temp -> next = head;
 head = temp;
}

item_t* find(const int x, item_t* head){
    while (head->value != x){
        head = head->next;
        if (head == NULL) break;
    }
    return head;
}

int main()
{
    cerr << "input value to find in the list:" << endl;
    int x;
    cin >> x;

    struct item *head = new item;

    initNode(head, 0);
    addNode(head, 1);
    addNode(head, 2);
    addNode(head, 3);
    addNode(head, 4);
    addNode(head, 5);
    addNode(head, 6);
    addNode(head, 7);
    addNode(head, 8);
    addNode(head, 9);
    
    if (item* p = find(x, head)){
        cout << p->value << " is in the list" << endl;
    }else{
        cout << "inputed value is not in the list" << endl;
    }
}
