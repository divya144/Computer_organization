//Objective:Hit rate using directive method and 4-way set associative

#include<bits/stdc++.h>
using namespace std;
long long int hextodec(string str1)
{
    long long int ans=0;
    for(int i=str1.length()-1;i>=0;i--)
    {
        if(str1[i]>='0'&&str1[i]<='9')
       { 
           int temp=(int)(str1[i]-'0');
           ans=ans+temp*pow(16,str1.length()-i-1);
        }
        else if(str1[i]>='A'&&str1[i]<='F')
        {
            int temp=((int)(str1[i]-'A'))+10;
            ans=ans+temp*pow(16,str1.length()-i-1);
        }
    }
    return ans;
}
void directive(int block,int word)
{
    ifstream file;
    file.open("input.txt");
    string str1;
    long long cache[block][word];
    long long int hit=0,miss=0;
    while(file>>str1)
    {
        int flag=0;
        long long int num=hextodec(str1),block_num=num/word,temp=block_num%block,temp2=num%word;
        long long int change=block_num*word;
        if(cache[temp][temp2]==num)
            hit++;
        else
        {
            for(int i=0;i<word;i++)   
            {
                cache[temp][i]=change;
                change=change+1;
            }
            miss++;
        }
    }
    //cout<<"Total number of hit(Direct): "<<hit<<endl;
    //cout<<"Total number of miss(Direct): "<<miss<<endl;
    cout<<miss<<"/"<<miss+hit;
    double rate=(double)miss/(double)(miss+hit);
    file.close();
   // return rate;
}
void set_associative_lru(int block,int word,int set)
{
    ifstream file;
    file.open("input.txt");
    string str1; 
    long long int cache[set][block][word]={0};
    long int timestamp[set][block]={0};
    long long int hit=0,miss=0;
    while(file>>str1)
    {
        int flag=0;
        long long int num=hextodec(str1);
        long long int block_num=num/word;
        long long int temp=block_num%set;
        long long int temp2=num%word;
        long long int change=block_num*word;
        int ind=0;
        for(int i=0;i<block;i++)
        {
            if(cache[temp][i][temp2]==num)
                {
                    flag++;
                    ind=i;
                }
        }
       if(flag!=0)
       {
           hit++;
           for(int i=0;i<set;i++)
           {
               for(int j=0;j<block;j++)
               {
                   if(timestamp[i][j]!=0)
                    timestamp[i][j]++;
               }
           }
           timestamp[temp][ind]=1;

       }
       else
       {
           long long ts=0;
           long long int index=0;
           int empty=0;
           for(int i=0;i<block;i++)
           {
               if(cache[temp][i][temp2]==0)
                { 
                    empty=1;
                    index=i;
                    break;
                }
           }
           if(empty==0)
            {
                for(int j=0;j<block;j++)
                    {
                        if(timestamp[temp][j]>ts)
                            {
                                ts=timestamp[temp][j];
                                index=j;
                             }
                    }
            }
           for(int i=0;i<set;i++)
               for(int j=0;j<block;j++)
                   if(timestamp[i][j]!=0)
                    timestamp[i][j]++;
            timestamp[temp][index]=1;
           for(int i=0;i<word;i++)
           {
               cache[temp][index][i]=change;
               change=change+1;
           }
           miss++;
       }
    }
       cout<<miss<<"/"<<miss+hit;

    file.close();
    //return rate;
}
 
void set_associative_fifo(int block,int word,int set)
{
    ifstream file;
    file.open("input.txt");
    string str1; 
    long long int cache[set][block][word]={0};
    long int timestamp[set][block]={0};
    long int hit=0,miss=0;
    while(file>>str1)
    {
        int flag=0;
        long long int num=hextodec(str1),block_num=num/word,temp=block_num%set,temp2=num%word;
        long long int change=block_num*word;
        for(int i=0;i<block;i++)
            if(cache[temp][i][temp2]==num)
                flag++;
       if(flag!=0)
           hit++;
       else
       {
           long long ts=0;
           long long int index=0;
           int empty=0;
           for(int i=0;i<block;i++)
           {
               if(cache[temp][i][temp2]==0)
                { 
                    empty=1;
                    index=i;
                    break;
                }
           }
           if(empty==0)
            {
                for(int j=0;j<block;j++)
                    {
                        if(timestamp[temp][j]>ts)
                            {
                                ts=timestamp[temp][j];
                                index=j;
                             }
                    }
            }
           for(int i=0;i<set;i++)
               for(int j=0;j<block;j++)
                   if(timestamp[i][j]!=0)
                    timestamp[i][j]++;
            timestamp[temp][index]=1;
           for(int i=0;i<word;i++)
           {
               cache[temp][index][i]=change;
               change=change+1;
           }
           miss++;
       }
    }
    // cout<<"Total number of hit(Associative): "<<hit<<endl;
    // cout<<"Total number of miss(Associative): "<<miss<<endl;
    double rate=(double)miss/(double)(miss+hit);
    cout<<miss<<"/"<<miss+hit;

    file.close();
    // return rate;
}
int main()
{
    cout<<"\t\t\t Direct"<<endl;
    cout<<"Cache Size\t1024\t\t\t2048\t\t\t4096\t\t\t\t8192"<<endl;
    cout<<"(16)\t\t";directive(64,16);cout<<"\t\t";directive(128,16);cout<<"\t\t";directive(256,16);cout<<"\t\t\t";directive(512,16);
    cout<<endl<<"(32)\t\t";directive(32,32);cout<<"\t\t";directive(64,32);cout<<"\t\t";directive(128,32);cout<<"\t\t\t";directive(256,32);
    cout<<endl<<"\t\t\t 4 way set associative"<<endl;
    cout<<"Cache Size\t1024\t\t\t2048\t\t\t4096\t\t\t8192"<<endl;
    cout<<"LRU(16)\t\t";set_associative_lru(4,16,16);cout<<"\t\t";set_associative_lru(4,16,32);cout<<"\t\t";set_associative_lru(4,16,64);cout<<"\t\t";set_associative_lru(4,16,128);
    cout<<endl<<"LRU(32)\t\t";set_associative_lru(4,32,8);cout<<"\t\t";set_associative_lru(4,32,16);cout<<"\t\t";set_associative_lru(4,32,32);cout<<"\t\t";set_associative_lru(4,32,64);
    cout<<endl<<"FIFO(16)\t";set_associative_fifo(4,16,16);cout<<"\t\t";set_associative_fifo(4,16,32);cout<<"\t\t";set_associative_fifo(4,16,64);cout<<"\t\t";set_associative_fifo(4,16,128);
    cout<<endl<<"FIFO(32)\t";set_associative_fifo(4,32,8);cout<<"\t\t";set_associative_fifo(4,32,16);cout<<"\t\t";set_associative_fifo(4,32,32);cout<<"\t\t";set_associative_fifo(4,32,64);
    cout<<endl;
  }
