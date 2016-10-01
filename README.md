# FunWIthFrequencies

This project explores the effects with manipulating frequencies of pictures. Part 0 sharpens a gray scale image; part 1 hybrids images such that it appears differently when looking from close or far; part 2 displays laplacian stack of image in part 1 to illustrate the effects; part 3 combines two image in seamless way. Fore more results: http://inst.eecs.berkeley.edu/~cs194-26/fa16/upload/files/proj3/cs194-26-acm/

![Example](hhttp://i.imgur.com/K8TiO6k.jpg)

# To run code
```
main()
```

# To run part 0
Set part flag to 0 and input image directory
```
part = 0;
...
original = im2single(imread(<name of image file>));
```

# To run part 1
Set part flag to 1 and input image directories
```
part = 1;
...
im1 = im2single(imread(<name of first image file>));
im2 = im2single(imread(<name of second image file>));
```

# To run part 2
Set part flag to 2 and input image directory
```
part = 2;
...
im12 = im2single(imread(<name of image file>));
```

# To run part 3
Set part flag to 3 and input image directories
```
part = 3;
...
im1 = im2single(imread(<name of first image file>));
im2 = im2single(imread(<name of second image file>));
```