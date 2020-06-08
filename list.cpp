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
    cerr << "input value to find" << endl;
    int x;
    cin >> x;

    struct item *head = new item;

    initNode(head, 202);
    addNode(head, 204);
    addNode(head, 206);
    addNode(head, 208);
    addNode(head, 522);
    addNode(head, 212);
    addNode(head, 214);
    addNode(head, 216);
    addNode(head, 218);
    addNode(head, 220);
    
    if (item* p = find(x, head)){
        cout << p->value << " is in the list" << endl;
    }else{
        cout << x << " is not in the list" << endl;
    }
}