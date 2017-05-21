/* clumsy method to turn assembled binary into text for jupiter ace word */

#include <stdio.h>

const char * forth_var[] = {
    "xyadd",
    "inv-x",
    "inv-y",
    "old-inv-x",
    "old-inv-y",
    "inv-state",
    "inv-anim-state",
    "leftmost-inv",
    "rightmost-inv",
    "bottommost-inv",
    "invaders-left",
    "update-inv-stats",
    "invaders-left 1+",
    "ship-x",
    "old-ship-x",
    "missile-x",
    "missile-y",
    "bombs",
    "last-dropper",
    "bomb-rel-idx",
    "inv-rows 1- inv-cols * inv-state +",
    "mother-x",
    "mother-state",
    "mother-dir",
    "disp-mother-ch",
    "upd-score"
};

#define maxfv (sizeof (forth_var) / sizeof (const char *))

int main()
{
    int c, c2, count;

    count = 0;

    while ((c = getc(stdin)) != EOF) {
        if (count++ % 8 == 0)
            printf("\n   ");
        if (c == 237) {   // ED
            c2 = getc(stdin);
            if (c2 != EOF) {
                if (c2 < maxfv)
                    printf(" %s ,", forth_var[c2]);
                else
                   printf(" %02X c, %02X c,", c, c2);
                if (count++ % 8 == 0)
                    printf("\n   ");
            }
        }
        else
            printf(" %02X c,", c);
    }
    printf("\n");
}
