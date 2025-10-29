#include <stdlib.h>
#include <stdio.h>
int main()
{
	int n ,rq[100],u,s,i,j,thm=0,move;
	printf("Enter the no of requests \n");
	scanf("%d",&n);
	printf("Enter the Requests \n");
	for(i=0; i<n; i++)
	{
	scanf("%d",&rq[i]);
	}
	printf("enter the  intial head\n");
	scanf("%d",&u);
	printf("enter the  disk size\n");
	scanf("%d",&s);
	printf("enter the  head move right(1) left(0) \n");
	scanf("%d",&move);
	for(i=0; i<n; i++)
	{
		for(j=0; j<n-i-1; j++)
		{
			if(rq[j]>rq[j+1])
			{
				int temp;
				temp=rq[j];
				rq[j]=rq[j+1];
				rq[j+1]=temp;
			}
		}
	}
	int index;
	for(i=0; i<n; i++)
	{
		if(u<rq[i])
		{
			index=i;
			break;
		}
	}
	if(move==1)
	{
		for(i=index; i<n; i++)
		{
			thm +=abs(rq[i]-u);
			u=rq[i];
		}
		thm=thm+abs((s-1)-u);
		u=s-1;
		for(i=index-1; i>=0; i--)
		{
			thm +=abs(rq[i]-u);
			u=rq[i];
		}		
	}
	else
	{
		for(i=index-1; i>=0; i--)
		{
			thm +=abs(rq[i]-u);
			u=rq[i];
		}
		thm=thm+abs(u-0);
		u=0;
		for(i=index; i<n; i++)
		{
			thm +=abs(rq[i]-u);
			u=rq[i];
		}		
		
	}
	printf("thm=%d",thm);
	return 0;
}






Steps:

Start

Read inputs

Number of requests n

Disk requests rq[0..n-1]

Initial head position u

Disk size s

Head movement direction move

Sort the requests in ascending order (using Bubble Sort or any sorting method).

Find the index of the first request greater than the current head position u.

Let this index be index.

If head moves to the right (move = 1):
a. Move the head from u to the largest request in rq[index..n-1]

Add absolute differences to thm
b. Move the head to the end of the disk (s-1)

Add absolute difference to thm
c. Move the head from the largest request back to the smallest request in rq[0..index-1]

Add absolute differences to thm

If head moves to the left (move = 0):
a. Move the head from u to the smallest request in rq[0..index-1]

Add absolute differences to thm
b. Move the head to the start of the disk (0)

Add absolute difference to thm
c. Move the head from the smallest request to the remaining requests in rq[index..n-1]

Add absolute differences to thm

Print total head movement (thm)

End
