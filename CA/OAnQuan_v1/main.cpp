#include <iostream>
using namespace std;
char str1[]="|     |  ";
char str2[]="   |";
char str3[]="|  ";
char str4[]="\n|_____|_____|_____|_____|_____|_____|_____|\n";
char str5[]=" _________________________________________\n";
char strAB[]=  "\n|  A  |_____|_____|_____|_____|_____|  B  |\n";
char strAnB[]= "\n|  A  |_____|_____|_____|_____|_____|     |\n";
char strnAB[]= "\n|     |_____|_____|_____|_____|_____|  B  |\n";
char strnAnB[]="\n|     |_____|_____|_____|_____|_____|     |\n";
char space1[]=" |  ";
char space2[]="  |  ";
char spac3[]="   |  ";
int a[]={0,5,5,5,5,5,0,5,5,5,5,5,10,10};
int  mode=1;
void print(int* a, int scores1,int scores2){
    cout<<"<---R    5     4     3     2     1    L--->\n";
    cout<<str5;
    cout<<str1;
    for (int i=11;i>6;--i){
        if (a[i]==0) cout<<spac3;
        else if (a[i]<10) cout<<a[i]<<space2;
        else cout<<a[i]<<space1;
    }
    cout<<str2;
    cout<<"   scores 2: "<<scores2;
    if (a[12]==10 && a[13]==10) cout<<strAB;
    else if (a[12]==10 && a[13]==0) cout<<strAnB;
    else if (a[12]==0 && a[13]==10) cout<<strnAB;
    else cout<<strnAnB;
    cout<<str3;
    for (int i=0;i<7;++i){
        if (a[i]==0) cout<<spac3;
        else if (a[i]<10) cout<<a[i]<<space2;
        else cout<<a[i]<<space1;
    }
    cout<<" scores 1: "<<scores1;
    cout<<str4;
    cout<<"<---L    1     2     3     4     5    R--->\n";
}
//
int calculateArray(int* a,int _pos,int isRight,int& scores1,int& scores2){
    int pos=_pos;
    int scores=0;
    int temp=a[pos];
    a[pos]=0;
    if (isRight) {
        while (true){
            pos++;
            if (pos==12) pos=0;
            // không còn quân để phát
            if (temp==0){
                // nếu đó là ô quan
                if (pos==0){
                    if (a[0]+a[12]!=0) return 0;

                }
                if (pos==6){
                    if (a[6]+a[13]!=0) return 0;
                }
                if (a[pos]==0) break;
                temp+=a[pos];
                a[pos]=0;
                continue;
            }
            a[pos]++;
            temp--;
        }
        int current=0;
        while (current==0){
            pos++;
            if (pos==12) pos=0;
            int temp=a[pos];
            a[pos]=0;
            if (pos==0) {
                temp+=a[12];
                a[12]=0;
            }
            if (pos==6) {
                temp+=a[13];
                a[13]=0;
            }
            if (temp==0) break;
            scores+=temp;
            pos++;
            if (pos==12) pos=0;

            current=a[pos];
            if (pos==0){
                current+=a[12];
            }
            if (pos==6){
                current+=a[13];
            }
        }
    }
    else  {
        while (true){
            pos--;
            if (pos==-1) pos=11;
            // không còn quân để phát
            if (temp==0){
                // nếu đó là ô quan
                if (pos==0){
                    if (a[0]+a[12]!=0) return 0;

                }
                if (pos==6){
                    if (a[6]+a[13]!=0) return 0;
                }
                if (a[pos]==0) break;
                temp+=a[pos];
                a[pos]=0;
                continue;
            }
            a[pos]++;
            temp--;
        }
        int current=0;
        while (current==0){
            pos--;
            if (pos==-1) pos=11;
            int temp=a[pos];
            if (pos==0) {
                temp+=a[12];
                a[12]=0;
            }
            if (pos==6) {
                temp+=a[13];
                a[13]=0;
            }
            if (temp==0) break;
            scores+=temp;
            a[pos]=0;
            pos--;
            if (pos==-1) pos=11;
            current=a[pos];
            if (pos==0){
                current+=a[12];
            }
            if (pos==6){
                current+=a[13];
            }
        }
    }
    if (_pos<6) scores1+=scores;
    else scores2+=scores;
    if (a[1]+a[2]+a[3]+a[4]+a[5]==0) {
        a[1]=1;a[2]=1;a[3]=1;a[4]=1;a[5]=1;
        scores1-=5;
    }
    if (a[7]+a[8]+a[9]+a[10]+a[11]==0) {
        a[7]=1;a[8]=1;a[9]=1;a[10]=1;a[11]=1;
        scores2-=5;
    }
    return scores2-scores1;
}
int endGame(int* a,int& scores1,int& scores2){
    if (a[0]+a[6]+a[12]+a[13]==0) {
        scores1+=a[1]+a[2]+a[3]+a[4]+a[5];
        scores2+=a[7]+a[8]+a[9]+a[10]+a[11];
        if (scores1>scores2) return 1;
        else if (scores2==scores1) return 0;
        else return 2;
    }
    return -1;
}
int miniMax(int* a,int scores1,int scores2,int depth,bool isMax,int& pos,int& isRight){
    int _pos,_isRight;
    int temp=endGame(a,scores1,scores2);
    if (temp==1) return -100;
    else if (temp==2) return 100;
    else if (temp==0) return 0;
    //  if (endGame(a,scores1,scores2)!=-1) return scores2-scores1;
    if (depth==0) return scores2-scores1;
    if (isMax){
        int Max=-500;
        for (int i=7;i<12;i++){
            if (a[i]!=0){
                int _a[14];
                for (int j=0;j<14;j++) _a[j]=a[j];
                int s1=scores1;
                int s2=scores2;
                calculateArray(_a,i,1,s1,s2);
                int res=miniMax(_a,s1,s2,depth-1,0,_pos,_isRight);
                if (Max<res) {
                    Max=res;
                    pos=i;
                    isRight=1;
                }
                for (int j=0;j<14;j++) _a[j]=a[j];
                s1=scores1;
                s2=scores2;
                calculateArray(_a,i,0,s1,s2);
                res=miniMax(_a,s1,s2,depth-1,0,_pos,_isRight);
                if (Max<res) {
                    Max=res;
                    pos=i;
                    isRight=0;
                }
            }
        }
        return Max;
    }
    else {
        int Min=500;
        for (int i=1;i<6;i++){
            if (a[i]!=0){
                int _a[14];
                for (int j=0;j<14;j++) _a[j]=a[j];
                int s1=scores1;
                int s2=scores2;
                calculateArray(_a,i,1,s1,s2);
                int res=miniMax(_a,s1,s2,depth-1,1,_pos,_isRight);
                if (Min>res) {
                    Min=res;
                    pos=i;
                    isRight=1;
                }
                for (int j=0;j<14;j++) _a[j]=a[j];
                s1=scores1;
                s2=scores2;
                calculateArray(_a,i,0,s1,s2);
                res=miniMax(_a,s1,s2,depth-1,1,_pos,_isRight);
                if (Min>res) {
                    Min=res;
                    pos=i;
                    isRight=0;
                }
            }
        }
        return Min;
    }

}

void control(){
    int scores1=0;
    int scores2=0;
    print(a,scores1,scores2);
    int result=-1;
    while (1){
        int pos;
        cout<<"\n     ----* Luot cua nguoi choi 1 *----\n";
        do {
            cout<<"     -> chon cac o tu 1-5 : ";
            cin>>pos;
        } while (!(pos>0 && pos<6 && a[pos]!=0));

        int direct;
        do {
            cout<<"     -> chon 0 de sang trai, 1 de sang phai : "; cin>>direct;
        } while (direct!=0 && direct!=1);
        calculateArray(a,pos,direct,scores1,scores2);
        print(a,scores1,scores2);
        result=endGame(a,scores1,scores2);
        if (result!=-1) break;
        if (mode==2) {
            cout << "\n     ----* Luot cua nguoi choi 2 *----\n";
            do {
                cout << "     --> chon cac o tu 1-5 : ";
                cin >> pos;
                pos += 6;
            } while (!(pos > 6 && pos < 12 && a[pos] != 0));

            do {
                cout << "     --> chon 0 de sang trai, 1 de sang phai : ";
                cin >> direct;
            } while (direct != 0 && direct != 1);
        }
        else {
            cout << "\n     ----* Luot cua nguoi choi 2(AI) *----\n";
//            do {
//               //pos=random 7-11
//            } while (!(pos > 6 && pos < 12 && a[pos] != 0));
//
//            do {
//                //direct =0/1
//            } while (direct != 0 && direct != 1);
            cout<<miniMax(a,scores1,scores2,7,1,pos,direct)<<endl;
            cout<<"     --> May chon o "<<pos-6<<endl;
            cout<<"     --> May chon huong : "<< direct<<endl;

        }

        calculateArray(a,pos,direct,scores1,scores2);
        print(a,scores1,scores2);
        result=endGame(a,scores1,scores2);
        if (result!=-1) break;
    }
    cout<<"\nTro choi ket thuc!!!\n";
    cout<<"Diem nguoi choi 1: "<<scores1<<endl;
    cout<<"Diem nguoi choi 2: "<<scores2<<endl;
    if (result==1) cout<<"Nguoi choi 1 thang!!";
    else if (result==2) cout<<"Nguoi choi 2 thang!!";
    else cout<<"Hoa roi!! ^_^";
}
int main() {
    int x,y;
    cout<<miniMax(a,0,0,3,1,x,y)<<endl;
    cout<<x<<" "<<y<<endl;
    return 0;
}
//<---R    5     4     3     2     1    L--->
//_________________________________________
//|     |     |  5  |     |  5  |     |     |   scores 2: 0
//|  A  |_____|_____|_____|_____|_____|  B  |
//|     |     |  5  |     |  5  |  1  |     |   scores 1: 0
//|_____|_____|_____|_____|_____|_____|_____|
//<---L    1     2     3     4     5    R--->
////
////     ----* Luot cua nguoi choi 1 *----
////     -> chon o:
////     -> chon huong:
//int foo(int pos){
//  return a[pos]
//};
