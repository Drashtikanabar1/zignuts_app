// class AriticalModel{

//   String? title;
//   String? categoryName;
//   String? canonicalUrl;
//   String? imgUrl;
   

//      AriticalModel({
//       this.title,
//       this.categoryName,
//       this.imgUrl,
//       this.canonicalUrl,
//     });
// }
class ArticleModel {
  List<Data>? data;

  ArticleModel({this.data});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  
  Title? title;
 
  String? jetpackFeaturedMediaUrl;

  String? shortlink;

  


  

 
  String? canonicalUrl;
  PrimaryCategory? primaryCategory;
  

  Data(
      {
      this.title,
     
     
      this.jetpackFeaturedMediaUrl,
  
      this.shortlink,
  
   
  

   
  
      this.canonicalUrl,
      this.primaryCategory,}
  );

  Data.fromJson(Map<String, dynamic> json) {
   
    title = json['title'] != null ? Title.fromJson(json['title']) : null;
    
    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
    

   
    
    canonicalUrl = json['canonical_url'];
    primaryCategory = json['primary_category'] != null
        ? PrimaryCategory.fromJson(json['primary_category'])
        : null;
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    if (title != null) {
      data['title'] = title!.toJson();
    }
    
    
    data['jetpack_featured_media_url'] = jetpackFeaturedMediaUrl;
    
    data['shortlink'] = shortlink;
    
 
 
    
    
    data['canonical_url'] = canonicalUrl;
    if (primaryCategory != null) {
      data['primary_category'] = primaryCategory!.toJson();
    }
    
    return data;
  }
}

class Title {
  String? rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    return data;
  }
}








class PrimaryCategory {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  PrimaryCategory(
      { this.termId,
      this.name,
      this.slug,
      this.termGroup,
      this.termTaxonomyId,
      this.taxonomy,
      this.description,
      this.parent,
      this.count,
      this.filter});

  PrimaryCategory.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    return data;
  }
}
