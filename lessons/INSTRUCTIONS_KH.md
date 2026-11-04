# 📚 ការបង្កើតប្រព័ន្ធគ្រប់គ្រងនិស្សិត Django
# (Complete Step-by-Step Guide: Building Django Student Management System from Scratch)

**សាកលវិទ្យាល័យ បៀលប្រាយ (Build Bright University - BBU)**  
**មហាវិទ្យាល័យវិទ្យាសាស្ត្រ និងបច្ចេកវិទ្យា (Faculty of Science & Technology)**  
**មុខវិជ្ជា៖ Python Project (Web Development with Django)**

---

## 🎯 សេចក្តីផ្តើម និងគោលបំណង (Project Overview)

ប្រព័ន្ធគ្រប់គ្រងនិស្សិត (**Student Management System**) នេះ គឺជាគម្រោង Full-Stack Web Application បង្កើតឡើងដោយប្រើប្រាស់ **Django Framework** (កំណែ 4.2 LTS) រួមជាមួយ **Django REST Framework**។ គម្រោងនេះត្រូវបានរចនាឡើងយ៉ាងពិសេសដើម្បីបង្រៀននិស្សិតអំពីស្ថាបត្យកម្ម **MVT (Model-View-Template)** ទំនើប ការរៀបចំទិន្នន័យជាភាសាខ្មែរ ការបញ្ចូលរូបថត Avatar ការគ្រប់គ្រងវគ្គសិក្សា និងការចុះឈ្មោះព្រមទាំងការគណនាពិន្ទុ GPA ដោយស្វ័យប្រវត្តិ។

---

## 🗺️ ផែនទីបង្ហាញផ្លូវនៃការបង្កើតគម្រោង (12-Step Implementation Roadmap)

```
[ជំហានទី ១] បង្កើត Virtual Environment & Django Project
     │
[ជំហានទី ២] កំណត់ Settings, .env, Khmer Localization & Apps
     │
[ជំហានទី ៣] បង្កើត Data Models (Students, Courses, Enrollments)
     │
[ជំហានទី ៤] ដំណើរការ Database Migrations (SQLite / PostgreSQL)
     │
[ជំហានទី ៥] បង្កើត Forms & ModelForms ជាមួយ Validation
     │
[ជំហានទី ៦] សរសេរ View Logic (FBVs និង CBVs)
     │
[ជំហានទី ៧] រៀបចំ URL Routing តាម App នីមួយៗ
     │
[ជំហានទី ៨] បង្កើត UI Templates ជាមួយ Bootstrap 5 & Inheritance
     │
[ជំហានទី ៩] រៀបចំ Static Files (CSS/JS) & Media Files (Avatar Upload)
     │
[ជំហានទី ១០] កំណត់រចនាសម្ព័ន្ធ Django Admin Panel & Auth
     │
[ជំហានទី ១១] បង្កើត REST API (Serializers, ViewSets, Routers)
     │
[ជំហានទី ១២] បង្កើត Seed Script ជាភាសាខ្មែរ & Automated Tests
```

---

## ជំហានទី ១៖ បង្កើត Virtual Environment និងគម្រោង Django

### ១.១ បង្កើត និងដំណើរការ Virtual Environment
Virtual Environment ជួយញែក Dependencies របស់គម្រោងដាច់ដោយឡែកពី Python របស់ប្រព័ន្ធកុំព្យូទ័រ៖

```bash
# ១. បង្កើតថតគម្រោង ហើយចូលទៅក្នុងថតនោះ
mkdir django_lesson
cd django_lesson

# ២. បង្កើត Virtual Environment ឈ្មោះ venv
python3 -m venv venv

# ៣. ដំណើរការ Virtual Environment
# នៅលើ macOS / Linux:
source venv/bin/activate
# នៅលើ Windows:
venv\Scripts\activate
```

### ១.២ ដំឡើង Dependencies ចាំបាច់
បង្កើតឯកសារ `requirements.txt` ដោយមានកញ្ចប់បណ្ណាល័យសំខាន់ៗ៖

```text
Django>=4.2,<5.0
djangorestframework>=3.14.0
python-decouple>=3.8
Pillow>=10.0.0
whitenoise>=6.5.0
django-filter>=23.2
```

ដំណើរការដំឡើងតាមរយៈ pip៖
```bash
pip install -r requirements.txt
```

### ១.៣ បង្កើត Django Project និង Apps ទាំង ៣
```bash
# បង្កើត Project មេ ឈ្មោះ student_system (សញ្ញាចុច '.' មានន័យថាបង្កើតក្នុងថតបច្ចុប្បន្ន)
django-admin startproject student_system .

# បង្កើត Apps ឯករាជ្យទាំង ៣
python manage.py startapp students
python manage.py startapp courses
python manage.py startapp enrollments
```

---

## ជំហានទី ២៖ ការកំណត់រចនាសម្ព័ន្ធ `student_system/settings.py`

### ២.១ បង្កើតឯកសារ `.env` សម្រាប់រក្សាសុវត្ថិភាព
កុំសរសេរ `SECRET_KEY` ឬពាក្យសម្ងាត់ Database ផ្ទាល់ក្នុងកូដ! ត្រូវប្រើ `python-decouple`៖

```ini
# .env
# ==============================================================================
# Environment Configuration Template for Django Student Management System
# Build Bright University (BBU) - Python Project
# Instructions: Copy this file to .env and adjust the values for your environment.
#   Command: cp .env.example .env
# ==============================================================================

# Django Core Settings
# In Production: Set DEBUG=False
DEBUG=False

# SECURITY WARNING: Use a strong, random secret key in production!
SECRET_KEY=django-insecure-replace-this-with-a-very-long-random-secret-key-in-production

# Allowed Hosts (Comma-separated hostnames/IPs)
ALLOWED_HOSTS=localhost,127.0.0.1,testserver,*.herokuapp.com,*.onrender.com

# CSRF Trusted Origins (Comma-separated HTTPS origins for Django 4.0+)
# Example: https://my-bbu-app.onrender.com,https://my-bbu-app.herokuapp.com
CSRF_TRUSTED_ORIGINS=http://localhost:8000,http://127.0.0.1:8000,https://*.herokuapp.com,https://*.onrender.com

# ------------------------------------------------------------------------------
# Database Configuration
# ------------------------------------------------------------------------------
# 1. Local Development (SQLite - default)
DB_ENGINE=django.db.backends.sqlite3
DB_NAME=db.sqlite3

# 2. Production Database (Render / Heroku automatically provide DATABASE_URL)
# DATABASE_URL=postgres://user:password@host:5432/dbname

# 3. Manual PostgreSQL Configuration (Alternative)
# DB_ENGINE=django.db.backends.postgresql
# DB_NAME=bbu_student_db
# DB_USER=postgres
# DB_PASSWORD=your_secure_password
# DB_HOST=localhost
# DB_PORT=5432

# ------------------------------------------------------------------------------
# Production Security Settings (Enable when SSL/HTTPS is active in Production)
# ------------------------------------------------------------------------------
SECURE_SSL_REDIRECT=False
SESSION_COOKIE_SECURE=False
CSRF_COOKIE_SECURE=False
SECURE_HSTS_SECONDS=0
SECURE_HSTS_INCLUDE_SUBDOMAINS=False
SECURE_HSTS_PRELOAD=False

# ------------------------------------------------------------------------------
# Internationalization & Localization
# ------------------------------------------------------------------------------
LANGUAGE_CODE=km
TIME_ZONE=Asia/Phnom_Penh
USE_I18N=True
USE_TZ=True

# Static and Media URLs
STATIC_URL=/static/
MEDIA_URL=/media/

```

### ២.២ កែប្រែ `student_system/settings.py`

```python
import os
from pathlib import Path
from decouple import config, Csv

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = config('SECRET_KEY', default='django-insecure-jt%luhks(%f-u+rud531b)xdv^*^6e=1hiu6awz9^83aj9)5-&')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = config('DEBUG', default=True, cast=bool)

ALLOWED_HOSTS = list(config('ALLOWED_HOSTS', default='localhost,127.0.0.1,testserver,.onrender.com,bbu-django-student-system-demo.onrender.com', cast=Csv()))
if '.onrender.com' not in ALLOWED_HOSTS:
    ALLOWED_HOSTS.append('.onrender.com')
RENDER_EXTERNAL_HOSTNAME = config('RENDER_EXTERNAL_HOSTNAME', default=None)
if RENDER_EXTERNAL_HOSTNAME and RENDER_EXTERNAL_HOSTNAME not in ALLOWED_HOSTS:
    ALLOWED_HOSTS.append(RENDER_EXTERNAL_HOSTNAME)

# CSRF Trusted Origins for Django 4.0+ in Production (HTTPS)
CSRF_TRUSTED_ORIGINS = list(config(
    'CSRF_TRUSTED_ORIGINS',
    default='http://localhost:8000,http://127.0.0.1:8000,https://*.onrender.com,https://bbu-django-student-system-demo.onrender.com',
    cast=Csv()
))
if 'https://*.onrender.com' not in CSRF_TRUSTED_ORIGINS:
    CSRF_TRUSTED_ORIGINS.append('https://*.onrender.com')
if 'https://bbu-django-student-system-demo.onrender.com' not in CSRF_TRUSTED_ORIGINS:
    CSRF_TRUSTED_ORIGINS.append('https://bbu-django-student-system-demo.onrender.com')
if RENDER_EXTERNAL_HOSTNAME:
    render_origin = f'https://{RENDER_EXTERNAL_HOSTNAME}'
    if render_origin not in CSRF_TRUSTED_ORIGINS:
        CSRF_TRUSTED_ORIGINS.append(render_origin)


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # REST Framework
    'rest_framework',
    
    # Custom Apps
    'students',
    'courses',
    'enrollments',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'student_system.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'student_system.wsgi.application'


# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': config('DB_ENGINE', default='django.db.backends.sqlite3'),
        'NAME': BASE_DIR / config('DB_NAME', default='db.sqlite3'),
        'USER': config('DB_USER', default=''),
        'PASSWORD': config('DB_PASSWORD', default=''),
        'HOST': config('DB_HOST', default=''),
        'PORT': config('DB_PORT', default=''),
    }
}

# Automatically configure database via DATABASE_URL if present (Render, Heroku, etc.)
DATABASE_URL = config('DATABASE_URL', default=None)
if DATABASE_URL:
    try:
        import dj_database_url
        DATABASES['default'] = dj_database_url.parse(
            DATABASE_URL,
            conn_max_age=600,
            conn_health_checks=True
        )
    except ImportError:
        pass


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

LANGUAGE_CODE = config('LANGUAGE_CODE', default='en-us')

TIME_ZONE = config('TIME_ZONE', default='UTC')

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'
STATICFILES_DIRS = [BASE_DIR / 'static']

# WhiteNoise configuration for static assets
STATICFILES_STORAGE = 'whitenoise.storage.CompressedStaticFilesStorage'
WHITENOISE_USE_FINDERS = True
WHITENOISE_MANIFEST_STRICT = False

# Media Files
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# REST Framework Configuration
REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 10,
}

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Authentication Configuration
LOGIN_URL = 'login'
LOGIN_REDIRECT_URL = 'home'
LOGOUT_REDIRECT_URL = 'home'

# ===== SECURITY SETTINGS =====
# These are configured via .env file for production/development differences

# SSL/HTTPS Configuration
SECURE_SSL_REDIRECT = config('SECURE_SSL_REDIRECT', default=False, cast=bool)
SESSION_COOKIE_SECURE = config('SESSION_COOKIE_SECURE', default=False, cast=bool)
CSRF_COOKIE_SECURE = config('CSRF_COOKIE_SECURE', default=False, cast=bool)

# HSTS (HTTP Strict-Transport-Security)
SECURE_HSTS_SECONDS = config('SECURE_HSTS_SECONDS', default=0, cast=int)
SECURE_HSTS_INCLUDE_SUBDOMAINS = config('SECURE_HSTS_INCLUDE_SUBDOMAINS', default=False, cast=bool)
SECURE_HSTS_PRELOAD = config('SECURE_HSTS_PRELOAD', default=False, cast=bool)

# Additional Security Headers
SECURE_CONTENT_SECURITY_POLICY = {
    'default-src': ("'self'",),
    'style-src': ("'self'", "https://cdn.jsdelivr.net"),
    'script-src': ("'self'", "https://cdn.jsdelivr.net"),
    'img-src': ("'self'", "data:", "https:"),
}

# X-Frame-Options
X_FRAME_OPTIONS = 'SAMEORIGIN'

# Content Security
SECURE_BROWSER_XSS_FILTER = True
SECURE_CONTENT_TYPE_NOSNIFF = True
```

---

## ជំហានទី ៣៖ ការបង្កើតស្រទាប់ទិន្នន័យ (Data Models)

### ៣.១ App សិស្ស៖ `students/models.py`
Model នេះតភ្ជាប់ជាមួយ `User` តាមរយៈ `OneToOneField` មានឈ្មោះជាភាសាខ្មែរ និងរូបថត Avatar៖

```python
from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.core.validators import MinValueValidator, MaxValueValidator

class Student(models.Model):
    """Model to store student information"""
    
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other'),
    ]
    
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='student')
    student_id = models.CharField(max_length=20, unique=True, help_text="Unique Student ID")
    khmer_name = models.CharField(
        max_length=150, 
        blank=True, 
        default='', 
        verbose_name="Khmer Name", 
        help_text="ឈ្មោះជាភាសាខ្មែរ (e.g. ពេជ្រ វល័ក្ខ)"
    )
    date_of_birth = models.DateField()
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    address = models.TextField()
    city = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    profile_picture = models.ImageField(upload_to='profiles/', blank=True, null=True)
    enrollment_date = models.DateField(auto_now_add=True)
    gpa = models.DecimalField(max_digits=3, decimal_places=2, default=0, 
                              validators=[MinValueValidator(0), MaxValueValidator(4)])
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['student_id']
        verbose_name_plural = "Students"
        indexes = [
            models.Index(fields=['student_id']),
            models.Index(fields=['user']),
            models.Index(fields=['khmer_name']),
        ]

    def get_primary_name(self):
        """Return Khmer name as primary; fall back to User full name or username"""
        if self.khmer_name:
            return self.khmer_name
        full_name = self.user.get_full_name()
        return full_name if full_name else self.user.username

    def __str__(self):
        return f"{self.student_id} - {self.get_primary_name()}"

    def get_absolute_url(self):
        return reverse('students:student_detail', kwargs={'pk': self.pk})
```

---

### ៣.២ App មុខវិជ្ជា៖ `courses/models.py`
មុខវិជ្ជាត្រូវបានបង្រៀនដោយគ្រូ (`ForeignKey` ទៅ `User`) និងមានកម្រិត Level (`100` ដល់ `400`)៖

```python
# student_system/courses/models.py

# import models from django.db module for database operations
from django.db import models
# import User from django.contrib.auth.models module for user authentication and authorization
from django.contrib.auth.models import User
# import reverse from django.urls module for URL reversal
from django.urls import reverse

# define the course model to store course information
# Course class inherits from models.Model class which provides all the functionality of a Django model
# and makes it possible to work with the database
class Course(models.Model):
    """Model to store course information"""
    
    # define level choices for the course
    LEVEL_CHOICES = [
        ('100', 'Beginner'),
        ('200', 'Intermediate'),
        ('300', 'Advanced'),
        ('400', 'Expert'),
    ]
    # define status choices for the course
    STATUS_CHOICES = [
        ('ACTIVE', 'Active'),
        ('INACTIVE', 'Inactive'),
        ('ARCHIVED', 'Archived'),
    ]
    
    code = models.CharField(max_length=10, unique=True, help_text="Course Code (e.g., CS101)")
    title = models.CharField(max_length=200)
    description = models.TextField()
    instructor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='taught_courses')
    credits = models.PositiveIntegerField(help_text="Credit hours for this course")
    level = models.CharField(max_length=3, choices=LEVEL_CHOICES)
    capacity = models.PositiveIntegerField(help_text="Maximum number of students")
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='ACTIVE')
    start_date = models.DateField()
    end_date = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # meta class is used to define the metadata of the model, such as the ordering, verbose_name_plural, and indexes.
    class Meta:
        ordering = ['code']
        verbose_name_plural = "Courses"
        indexes = [
            models.Index(fields=['code']),
            models.Index(fields=['status']),
        ]

    # __str__ method is used to return the string representation of the model
    # it is used to display the string representation of the model in the admin interface and in the shell
    def __str__(self):
        return f"{self.code} - {self.title}"

    # get_absolute_url method is used to return the URL of the model
    # it is used to display the URL of the model in the admin interface and in the shell
    def get_absolute_url(self):
        return reverse('courses:course_detail', kwargs={'pk': self.pk})
    
    # is_available property is used to check if the course is currently available for enrollment
    # @property decorator is used to define a property method that can be accessed as an attribute of the model
    # it is used to check if the course is currently available for enrollment
    @property
    def is_available(self):
        """Check if course is currently available for enrollment"""
        return self.status == 'ACTIVE'

```

---

### ៣.៣ App ចុះឈ្មោះ៖ `enrollments/models.py`
ភ្ជាប់សិស្ស និងមុខវិជ្ជាចូលគ្នា (`Many-to-Many through Enrollment`) ព្រមទាំងគណនា Grade និង GPA ស្វ័យប្រវត្តិ៖

```python
from django.db import models
from students.models import Student
from courses.models import Course
from django.urls import reverse
from django.core.validators import MinValueValidator, MaxValueValidator

class Enrollment(models.Model):
    """Model to store student course enrollment information"""
    
    STATUS_CHOICES = [
        ('ENROLLED', 'Enrolled'),
        ('COMPLETED', 'Completed'),
        ('DROPPED', 'Dropped'),
        ('SUSPENDED', 'Suspended'),
    ]
    
    student = models.ForeignKey(Student, on_delete=models.CASCADE, related_name='enrollments')
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='enrollments')
    enrollment_date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='ENROLLED')
    grade = models.CharField(max_length=2, blank=True, null=True, help_text="Letter grade (A, B, C, D, F)")
    score = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True,
                               validators=[MinValueValidator(0), MaxValueValidator(100)])
    attendance_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0,
                                               validators=[MinValueValidator(0), MaxValueValidator(100)])
    completed_date = models.DateField(null=True, blank=True)
    notes = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('student', 'course')
        ordering = ['-enrollment_date']
        verbose_name_plural = "Enrollments"
        indexes = [
            models.Index(fields=['student', 'course']),
            models.Index(fields=['status']),
        ]

    def __str__(self):
        return f"{self.student.student_id} - {self.course.code}"

    def get_absolute_url(self):
        return reverse('enrollments:enrollment_detail', kwargs={'pk': self.pk})

    def calculate_grade(self):
        """Calculate letter grade based on score"""
        if self.score is None:
            return None
        
        if self.score >= 90:
            return 'A'
        elif self.score >= 80:
            return 'B'
        elif self.score >= 70:
            return 'C'
        elif self.score >= 60:
            return 'D'
        else:
            return 'F'
    
    def save(self, *args, **kwargs):
        """Automatically calculate grade before saving"""
        if self.score and not self.grade:
            self.grade = self.calculate_grade()
        super().save(*args, **kwargs)

```

---

## ជំហានទី ៤៖ ការអនុវត្ត Migrations បង្កើតតារាង Database

ក្រោយពីបង្កើត Models រួចរាល់ សូមដំណើរការ Migration Commands ដូចខាងក្រោម៖

```bash
# ១. បង្កើត migration files
python manage.py makemigrations students
python manage.py makemigrations courses
python manage.py makemigrations enrollments

# ២. អនុវត្តចូលទៅក្នុង Database (SQLite / Postgres)
python manage.py migrate

# ៣. បង្កើត Admin Superuser
python manage.py createsuperuser
# បញ្ចូល Username (ឧ. admin), Email, និង Password (ឧ. admin123456)
```

---

## ជំហានទី ៥៖ ការបង្កើត Django Forms សម្រាប់ទទួល Input

### ៥.១ App សិស្ស៖ `students/forms.py`
យើងបង្កើត Form ចំនួន ៣៖ Form កែសម្រួលព័ត៌មានផ្ទាល់ខ្លួន, Form ព័ត៌មានគណនី User, និង Form ចុះឈ្មោះសិស្សថ្មី៖

```python
from django import forms
from .models import Student
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class StudentForm(forms.ModelForm):
    """Form for creating and updating student information"""
    def __init__(self, *args, user=None, **kwargs):
        super().__init__(*args, **kwargs)
        if user and not user.is_staff and 'student_id' in self.fields:
            self.fields['student_id'].disabled = True

    class Meta:
        model = Student
        fields = ['student_id', 'khmer_name', 'date_of_birth', 'gender', 'phone_number', 
                  'address', 'city', 'country', 'profile_picture']
        widgets = {
            'student_id': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Student ID'}),
            'khmer_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'ឈ្មោះជាភាសាខ្មែរ (e.g. ពេជ្រ វល័ក្ខ)'}),
            'date_of_birth': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'gender': forms.Select(attrs={'class': 'form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Phone Number'}),
            'address': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'city': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'City'}),
            'country': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),
            'profile_picture': forms.FileInput(attrs={'class': 'form-control'}),
        }

class UserForm(forms.ModelForm):
    """Form for creating and updating user information"""
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'email']
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control'}),
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
        }

class StudentRegistrationForm(UserCreationForm):
    """Form for student registration combining User and Student info"""
    khmer_name = forms.CharField(
        max_length=150, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'ឈ្មោះជាភាសាខ្មែរ (Khmer Name)'})
    )
    first_name = forms.CharField(
        max_length=30, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'First Name (Latin)'})
    )
    last_name = forms.CharField(
        max_length=30, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Last Name (Latin)'})
    )
    email = forms.EmailField(
        required=True,
        widget=forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'Email address'})
    )
    student_id = forms.CharField(
        max_length=20, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Student ID (e.g. STU1001)'})
    )
    date_of_birth = forms.DateField(
        required=True,
        widget=forms.DateInput(attrs={'class': 'form-control', 'type': 'date'})
    )
    gender = forms.ChoiceField(
        choices=Student.GENDER_CHOICES,
        widget=forms.Select(attrs={'class': 'form-select'})
    )
    phone_number = forms.CharField(
        max_length=20, required=False,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Phone Number'})
    )
    address = forms.CharField(
        required=True,
        widget=forms.Textarea(attrs={'class': 'form-control', 'rows': 2, 'placeholder': 'Street Address'})
    )
    city = forms.CharField(
        max_length=100, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'City'})
    )
    country = forms.CharField(
        max_length=100, required=True,
        widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'})
    )

    class Meta:
        model = User
        fields = ('username', 'first_name', 'last_name', 'email', 'password1', 'password2',
                  'student_id', 'khmer_name', 'date_of_birth', 'gender', 'phone_number', 'address', 'city', 'country')
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Username'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'password1' in self.fields:
            self.fields['password1'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Create password'})
        if 'password2' in self.fields:
            self.fields['password2'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Confirm password'})

    def clean_student_id(self):
        student_id = self.cleaned_data.get('student_id')
        if student_id and Student.objects.filter(student_id=student_id).exists():
            raise forms.ValidationError("A student with this Student ID already exists.")
        return student_id

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if email and User.objects.filter(email=email).exists():
            raise forms.ValidationError("A user with this email address already exists.")
        return email

```

### ៥.២ App មុខវិជ្ជា៖ `courses/forms.py`
```python
from django import forms
from .models import Course

class CourseForm(forms.ModelForm):
    """Form for creating and updating courses"""
    class Meta:
        model = Course
        fields = ['code', 'title', 'description', 'instructor', 'credits', 
                  'level', 'capacity', 'status', 'start_date', 'end_date']
        widgets = {
            'code': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Course Code'}),
            'title': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Course Title'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 5}),
            'instructor': forms.Select(attrs={'class': 'form-control'}),
            'credits': forms.NumberInput(attrs={'class': 'form-control', 'type': 'number'}),
            'level': forms.Select(attrs={'class': 'form-control'}),
            'capacity': forms.NumberInput(attrs={'class': 'form-control', 'type': 'number'}),
            'status': forms.Select(attrs={'class': 'form-control'}),
            'start_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'end_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
        }

class CourseFilterForm(forms.Form):
    """Form for filtering courses"""
    LEVEL_CHOICES = [('', '--- All Levels ---')] + list(Course.LEVEL_CHOICES)
    STATUS_CHOICES = [('', '--- All Status ---')] + list(Course.STATUS_CHOICES)
    
    level = forms.ChoiceField(choices=LEVEL_CHOICES, required=False, widget=forms.Select(attrs={'class': 'form-control'}))
    status = forms.ChoiceField(choices=STATUS_CHOICES, required=False, widget=forms.Select(attrs={'class': 'form-control'}))
    search = forms.CharField(max_length=100, required=False, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Search courses...'}))

```

### ៥.៣ App ចុះឈ្មោះ៖ `enrollments/forms.py`
```python
from django import forms
from .models import Enrollment
from students.models import Student
from courses.models import Course

class StudentChoiceField(forms.ModelChoiceField):
    def label_from_instance(self, obj):
        eng_name = obj.user.get_full_name() if (obj.user and obj.user.get_full_name()) else (obj.user.username if obj.user else "")
        if obj.khmer_name and eng_name and obj.khmer_name != eng_name:
            return f"{obj.student_id} - {obj.khmer_name} ({eng_name})"
        elif obj.khmer_name:
            return f"{obj.student_id} - {obj.khmer_name}"
        elif eng_name:
            return f"{obj.student_id} - {eng_name}"
        return str(obj)

class CourseChoiceField(forms.ModelChoiceField):
    def label_from_instance(self, obj):
        instructor_str = f" | Prof: {obj.instructor.get_full_name() or obj.instructor.username}" if obj.instructor else ""
        return f"{obj.code} - {obj.title} ({obj.get_level_display()}){instructor_str}"

class EnrollmentForm(forms.ModelForm):
    """Form for creating and updating enrollments with searchable selections"""
    student = StudentChoiceField(
        queryset=Student.objects.select_related('user').all().order_by('student_id'),
        widget=forms.Select(attrs={
            'class': 'form-select searchable-select',
            'id': 'id_student',
        }),
        help_text="ស្វែងរកតាមអត្តលេខ, ឈ្មោះខ្មែរ, ឬឈ្មោះឡាតាំង"
    )
    course = CourseChoiceField(
        queryset=Course.objects.select_related('instructor').all().order_by('code'),
        widget=forms.Select(attrs={
            'class': 'form-select searchable-select',
            'id': 'id_course',
        }),
        help_text="ស្វែងរកតាមកូដមុខវិជ្ជា, ឈ្មោះមុខវិជ្ជា, ឬសាស្រ្តាចារ្យ"
    )

    class Meta:
        model = Enrollment
        fields = ['student', 'course', 'status']
        widgets = {
            'status': forms.Select(attrs={'class': 'form-select'}),
        }

class GradeForm(forms.ModelForm):
    """Form for entering student grades and scores"""
    class Meta:
        model = Enrollment
        fields = ['score', 'attendance_percentage', 'notes']
        widgets = {
            'score': forms.NumberInput(attrs={'class': 'form-control', 'type': 'number', 'min': '0', 'max': '100', 'step': '0.01'}),
            'attendance_percentage': forms.NumberInput(attrs={'class': 'form-control', 'type': 'number', 'min': '0', 'max': '100', 'step': '0.01'}),
            'notes': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
        }

class EnrollmentFilterForm(forms.Form):
    """Form for filtering enrollments"""
    STATUS_CHOICES = [('', '--- All Status ---')] + list(Enrollment.STATUS_CHOICES)
    
    status = forms.ChoiceField(choices=STATUS_CHOICES, required=False, widget=forms.Select(attrs={'class': 'form-control'}))
    student = forms.CharField(max_length=100, required=False, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Search student...'}))
    course = forms.CharField(max_length=100, required=False, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Search course...'}))

```

---

## ជំហានទី ៦៖ ការសរសេរ View Logic (FBVs និង CBVs)

### ៦.១ សរសេរ `students/views.py`
បង្ហាញទាំង Function-Based Views (FBV) និង Class-Based Views (CBV)៖

```python
from django.shortcuts import render, redirect, get_object_or_404
from django.views import View
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login
from django.contrib.auth.models import User
from django.contrib import messages
from django.urls import reverse_lazy
from django.db.models import Q
from django.core.paginator import Paginator
from django.core.exceptions import PermissionDenied
from .models import Student
from .forms import StudentForm, UserForm, StudentRegistrationForm

# Function-Based Views (FBV)

@login_required
def student_list(request):
    """List all students with search functionality and pagination (Staff only; students redirected to own profile)"""
    if not request.user.is_staff:
        if hasattr(request.user, 'student'):
            messages.info(request, "Students can only access their own profile.")
            return redirect('students:student_detail', pk=request.user.student.pk)
        raise PermissionDenied("Only staff members can view the student directory.")

    search_query = request.GET.get('q', '').strip()
    students_qs = Student.objects.select_related('user').all()
    
    if search_query:
        students_qs = students_qs.filter(
            Q(student_id__icontains=search_query) |
            Q(khmer_name__icontains=search_query) |
            Q(user__first_name__icontains=search_query) |
            Q(user__last_name__icontains=search_query) |
            Q(user__email__icontains=search_query)
        )
    
    students_qs = students_qs.order_by('student_id')
    paginator = Paginator(students_qs, 20)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'students': page_obj,
        'page_obj': page_obj,
        'search_query': search_query,
    }
    return render(request, 'students/student_list.html', context)


@login_required
def student_detail(request, pk):
    """Display detailed information about a student (Staff or student owner only)"""
    student = get_object_or_404(Student, pk=pk)
    
    # Ownership/Role Authorization check
    if not request.user.is_staff and student.user != request.user:
        raise PermissionDenied("You are not authorized to view other students' profiles.")
    
    enrollments = student.enrollments.all()
    
    context = {
        'student': student,
        'enrollments': enrollments,
    }
    return render(request, 'students/student_detail.html', context)

@login_required
def student_update(request, pk):
    """Update student information (Staff or student owner only)"""
    student = get_object_or_404(Student, pk=pk)
    
    # Ownership/Role Authorization check
    if not request.user.is_staff and student.user != request.user:
        raise PermissionDenied("You are not authorized to edit this student profile.")
    
    if request.method == 'POST':
        student_form = StudentForm(request.POST, request.FILES, instance=student, user=request.user)
        user_form = UserForm(request.POST, instance=student.user)
        
        if student_form.is_valid() and user_form.is_valid():
            student_form.save()
            user_form.save()
            messages.success(request, f"Student {student.student_id} updated successfully!")
            return redirect('students:student_detail', pk=student.pk)
    else:
        student_form = StudentForm(instance=student, user=request.user)
        user_form = UserForm(instance=student.user)
    
    context = {
        'student_form': student_form,
        'user_form': user_form,
        'form': student_form,
        'student': student,
        'title': f'Edit Student: {student.student_id}',
    }
    return render(request, 'students/student_form.html', context)

def register_student(request):
    """Register a new student"""
    if request.method == 'POST':
        form = StudentRegistrationForm(request.POST)
        if form.is_valid():
            # Create user
            user = User.objects.create_user(
                username=form.cleaned_data['username'],
                first_name=form.cleaned_data['first_name'],
                last_name=form.cleaned_data['last_name'],
                email=form.cleaned_data['email'],
                password=form.cleaned_data['password1'],
            )
            
            # Create student profile
            student = Student.objects.create(
                user=user,
                student_id=form.cleaned_data['student_id'],
                khmer_name=form.cleaned_data.get('khmer_name', ''),
                date_of_birth=form.cleaned_data['date_of_birth'],
                gender=form.cleaned_data['gender'],
                phone_number=form.cleaned_data.get('phone_number', ''),
                address=form.cleaned_data['address'],
                city=form.cleaned_data['city'],
                country=form.cleaned_data['country'],
            )
            
            messages.success(request, f"Welcome {user.first_name}! Your student registration is complete.")
            
            # Auto-login if not already logged in
            if not request.user.is_authenticated:
                login(request, user)
                return redirect('students:student_detail', pk=student.pk)
            
            return redirect('students:student_detail', pk=student.pk)
    else:
        form = StudentRegistrationForm()
    
    context = {'form': form}
    return render(request, 'students/register.html', context)

@login_required
def student_delete(request, pk):
    """Delete a student (Staff only)"""
    if not request.user.is_staff:
        raise PermissionDenied("Only staff and administrators can delete student records.")

    student = get_object_or_404(Student, pk=pk)
    if request.method == 'POST':
        user = student.user
        student.delete()
        user.delete()
        messages.success(request, f"Student {student.student_id} deleted successfully.")
        return redirect('students:student_list')
    
    context = {'student': student}
    return render(request, 'students/student_confirm_delete.html', context)

# Class-Based Views (CBV)

class StudentListView(LoginRequiredMixin, UserPassesTestMixin, ListView):
    """Class-based view for listing students (Staff only; students redirected to own profile)"""
    model = Student
    template_name = 'students/student_list.html'
    context_object_name = 'students'
    paginate_by = 20

    def test_func(self):
        return self.request.user.is_staff

    def handle_no_permission(self):
        if self.request.user.is_authenticated and hasattr(self.request.user, 'student'):
            messages.info(self.request, "Students can only access their own profile.")
            return redirect('students:student_detail', pk=self.request.user.student.pk)
        return super().handle_no_permission()
    
    def get_queryset(self):
        queryset = Student.objects.select_related('user').all()
        search_query = self.request.GET.get('q', '').strip()
        
        if search_query:
            queryset = queryset.filter(
                Q(student_id__icontains=search_query) |
                Q(khmer_name__icontains=search_query) |
                Q(user__first_name__icontains=search_query) |
                Q(user__last_name__icontains=search_query) |
                Q(user__email__icontains=search_query)
            )
        
        return queryset.order_by('student_id')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['search_query'] = self.request.GET.get('q', '').strip()
        return context

class StudentDetailView(LoginRequiredMixin, UserPassesTestMixin, DetailView):
    """Class-based view for student details (Staff or student owner only)"""
    model = Student
    template_name = 'students/student_detail.html'
    context_object_name = 'student'

    def test_func(self):
        student = self.get_object()
        return self.request.user.is_staff or student.user == self.request.user
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['enrollments'] = self.object.enrollments.all()
        return context

class StudentCreateView(LoginRequiredMixin, UserPassesTestMixin, CreateView):
    """Class-based view for creating a new student (Staff only)"""
    model = Student
    form_class = StudentForm
    template_name = 'students/student_form.html'
    success_url = reverse_lazy('students:student_list')

    def test_func(self):
        return self.request.user.is_staff

    def form_valid(self, form):
        if not hasattr(form.instance, 'user') or form.instance.user_id is None:
            if not hasattr(self.request.user, 'student'):
                form.instance.user = self.request.user
            else:
                student_id = form.cleaned_data.get('student_id', '')
                username = f"std_{student_id.lower()}"
                user, _ = User.objects.get_or_create(
                    username=username,
                    defaults={'first_name': form.cleaned_data.get('khmer_name', student_id)}
                )
                form.instance.user = user
        return super().form_valid(form)

class StudentUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    """Class-based view for updating student information (Staff or student owner only)"""
    model = Student
    form_class = StudentForm
    template_name = 'students/student_form.html'
    success_url = reverse_lazy('students:student_list')

    def test_func(self):
        student = self.get_object()
        return self.request.user.is_staff or student.user == self.request.user

    def get_form_kwargs(self):
        kwargs = super().get_form_kwargs()
        kwargs['user'] = self.request.user
        return kwargs

class StudentDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    """Class-based view for deleting a student (Staff only)"""
    model = Student
    template_name = 'students/student_confirm_delete.html'
    success_url = reverse_lazy('students:student_list')

    def test_func(self):
        return self.request.user.is_staff

```

### ៦.២ សរសេរ Home View ក្នុង `student_system/views.py`
```python
from django.shortcuts import render
from students.models import Student
from courses.models import Course
from enrollments.models import Enrollment

def home(request):
    """Home page with system statistics and 3-role demo test accounts"""
    test_accounts = [
        {
            'role_title': 'អ្នកគ្រប់គ្រងប្រព័ន្ធ (Admin / Superuser)',
            'role_key': 'admin',
            'username': 'admin',
            'password': 'admin123456',
            'badge': 'Superuser & Staff',
            'badge_class': 'bg-dark text-white',
            'border_class': 'border-dark',
            'icon': '👑',
            'description': 'សិទ្ធិខ្ពស់បំផុតក្នុងប្រព័ន្ធ អាចចូលផ្ទាំងគ្រប់គ្រង Django Admin Panel និងគ្រប់គ្រងទិន្នន័យទាំងអស់។',
            'scope': [
                'ចូលប្រើ Django Admin Panel (/admin/)',
                'បង្កើត កែប្រែ និងលុបនិស្សិតទាំងអស់',
                'គ្រប់គ្រងវគ្គសិក្សា និងការចុះឈ្មោះពេញលេញ',
            ],
            'login_url': '/admin/',
            'button_text': 'ចូលគ្រប់គ្រង (Admin)',
            'btn_class': 'btn-dark',
        },
        {
            'role_title': 'សាស្ត្រាចារ្យ (Faculty / Teacher)',
            'role_key': 'teacher',
            'username': 'teacher',
            'password': 'teacher123456',
            'badge': 'Faculty / Staff',
            'badge_class': 'bg-primary text-white',
            'border_class': 'border-primary',
            'icon': '👨‍🏫',
            'description': 'សិទ្ធិជាគ្រូបង្រៀន/បុគ្គលិក អាចមើលបញ្ជីសិស្សទាំងអស់ គ្រប់គ្រងវគ្គសិក្សា និងដាក់ពិន្ទុ Grade។',
            'scope': [
                'មើលបញ្ជីឈ្មោះនិស្សិតទូទាំងសាកលវិទ្យាល័យ',
                'គ្រប់គ្រងវគ្គសិក្សា និងកែប្រែការចុះឈ្មោះ',
                'ដាក់ពិន្ទុ (Add Grades) និងលុប/កែប្រែទិន្នន័យ',
            ],
            'login_url': '/login/',
            'button_text': 'ចូលជាគ្រូ (Teacher)',
            'btn_class': 'btn-primary',
        },
        {
            'role_title': 'និស្សិត (Regular Student)',
            'role_key': 'student',
            'username': 'student',
            'password': 'student123456',
            'badge': 'Student: STU-BBU-001',
            'badge_class': 'bg-success text-white',
            'border_class': 'border-success',
            'icon': '🎓',
            'description': 'សិទ្ធិជានិស្សិតធម្មតា មើលនិងកែប្រែបានតែប្រវត្តិរូបផ្ទាល់ខ្លួន មិនអាចមើល កែប្រែ ឬលុបអ្នកដទៃឡើយ។',
            'scope': [
                'មើល និងកែប្រែបានតែប្រវត្តិរូបផ្ទាល់ខ្លួន',
                'មើល Transcript និងលទ្ធផលសិក្សាផ្ទាល់ខ្លួន',
                '🔒 ត្រូវបានរារាំង មិនឱ្យមើល កែប្រែ ឬលុបអ្នកដទៃ (403)',
            ],
            'login_url': '/login/',
            'button_text': 'ចូលជានិស្សិត (Student)',
            'btn_class': 'btn-success',
        },
    ]

    context = {
        'total_students': Student.objects.count(),
        'total_courses': Course.objects.count(),
        'total_enrollments': Enrollment.objects.count(),
        'active_students': Student.objects.filter(is_active=True).count(),
        'active_courses': Course.objects.filter(status='ACTIVE').count(),
        'test_accounts': test_accounts,
    }
    return render(request, 'home.html', context)


```

---

## ជំហានទី ៧៖ ការរៀបចំ URL Routing

### ៧.១ Project Root URLs: `student_system/urls.py`
```python
"""
URL configuration for student_system project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
"""
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import RedirectView
from django.templatetags.static import static as static_url
from django.http import JsonResponse
from . import views

urlpatterns = [
    # Favicon and Chrome DevTools endpoints (prevents 404 log noise)
    path('favicon.ico', RedirectView.as_view(url=static_url('images/favicon.ico'), permanent=True)),
    path('.well-known/appspecific/com.chrome.devtools.json', lambda request: JsonResponse({}, status=200)),
    
    path('', views.home, name='home'),
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    
    # Direct Authentication URLs
    path('login/', auth_views.LoginView.as_view(), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('accounts/', include('django.contrib.auth.urls')),
    
    # API URLs
    path('api/', include('student_system.api_urls')),
    
    # App URLs
    path('students/', include('students.urls')),
    path('courses/', include('courses.urls')),
    path('enrollments/', include('enrollments.urls')),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    # Serve static files from both STATICFILES_DIRS and STATIC_ROOT
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=str(settings.BASE_DIR / 'static'))

```

### ៧.២ Students URLs: `students/urls.py`
```python
from django.urls import path
from . import views

app_name = 'students'

urlpatterns = [
    # FBV URLs
    path('', views.student_list, name='student_list'),
    path('register/', views.register_student, name='register'),
    path('<int:pk>/', views.student_detail, name='student_detail'),
    path('<int:pk>/update/', views.student_update, name='student_update'),
    path('<int:pk>/delete/', views.student_delete, name='student_delete'),
    
    # CBV URLs
    path('cbv/list/', views.StudentListView.as_view(), name='student_list_cbv'),
    path('cbv/<int:pk>/', views.StudentDetailView.as_view(), name='student_detail_cbv'),
    path('cbv/create/', views.StudentCreateView.as_view(), name='student_create_cbv'),
    path('cbv/<int:pk>/update/', views.StudentUpdateView.as_view(), name='student_update_cbv'),
    path('cbv/<int:pk>/delete/', views.StudentDeleteView.as_view(), name='student_delete_cbv'),
]

```

### ៧.៣ courses URLs: `courses/urls.py`
```python
# student_system/courses/urls.py

# import path from django.urls module for URL reversal
from django.urls import path
# import views from the current module for view functions
from . import views

# set the application name for URL reversal
app_name = 'courses'

# define the URL patterns for the courses app
urlpatterns = [
    # FBV URLs
    # path('') creates a URL pattern for the root URL
    # views.course_list is the view function that will be called when the URL is accessed
    # name='course_list' is the name of the URL pattern
    path('', views.course_list, name='course_list'),
    # path('<int:pk>/', ...) creates a URL pattern for a specific course by its primary key
    # views.course_detail is the view function that will be called when the URL is accessed
    # name='course_detail' is the name of the URL pattern
    path('<int:pk>/', views.course_detail, name='course_detail'),
    # path('create/', ...) creates a URL pattern for creating a new course
    # views.course_create is the view function that will be called when the URL is accessed
    # name='course_create' is the name of the URL pattern
    path('create/', views.course_create, name='course_create'),
    # path('<int:pk>/update/', ...) creates a URL pattern for updating a specific course by its primary key
    # views.course_update is the view function that will be called when the URL is accessed
    # name='course_update' is the name of the URL pattern
    path('<int:pk>/update/', views.course_update, name='course_update'),
    # path('<int:pk>/delete/', ...) creates a URL pattern for deleting a specific course by its primary key
    # views.course_delete is the view function that will be called when the URL is accessed
    # name='course_delete' is the name of the URL pattern
    path('<int:pk>/delete/', views.course_delete, name='course_delete'),
    
    # CBV URLs
    # path('cbv/list/', ...) creates a URL pattern for the root URL
    # views.CourseListView.as_view() is the view function that will be called when the URL is accessed
    # name='course_list_cbv' is the name of the URL pattern
    path('cbv/list/', views.CourseListView.as_view(), name='course_list_cbv'),
    # path('cbv/<int:pk>/', ...) creates a URL pattern for a specific course by its primary key
    # views.CourseDetailView.as_view() is the view function that will be called when the URL is accessed
    # name='course_detail_cbv' is the name of the URL pattern
    path('cbv/<int:pk>/', views.CourseDetailView.as_view(), name='course_detail_cbv'),
    # path('cbv/create/', ...) creates a URL pattern for creating a new course
    # views.CourseCreateView.as_view() is the view function that will be called when the URL is accessed
    # name='course_create_cbv' is the name of the URL pattern
    path('cbv/create/', views.CourseCreateView.as_view(), name='course_create_cbv'),
    # path('cbv/<int:pk>/update/', ...) creates a URL pattern for updating a specific course by its primary key
    # views.CourseUpdateView.as_view() is the view function that will be called when the URL is accessed
    # name='course_update_cbv' is the name of the URL pattern
    path('cbv/<int:pk>/update/', views.CourseUpdateView.as_view(), name='course_update_cbv'),
    # path('cbv/<int:pk>/delete/', ...) creates a URL pattern for deleting a specific course by its primary key
    # views.CourseDeleteView.as_view() is the view function that will be called when the URL is accessed
    # name='course_delete_cbv' is the name of the URL pattern
    path('cbv/<int:pk>/delete/', views.CourseDeleteView.as_view(), name='course_delete_cbv'),
]

```

### ៧.៤ enrollments URLs: `enrollments/urls.py`
```python
from django.urls import path
from . import views

app_name = 'enrollments'

urlpatterns = [
    # FBV URLs
    path('', views.enrollment_list, name='enrollment_list'),
    path('<int:pk>/', views.enrollment_detail, name='enrollment_detail'),
    path('create/', views.enrollment_create, name='enrollment_create'),
    path('<int:pk>/update/', views.enrollment_update, name='enrollment_update'),
    path('<int:pk>/delete/', views.enrollment_delete, name='enrollment_delete'),
    path('<int:pk>/grade/', views.add_grade, name='add_grade'),
    path('transcript/<str:student_id>/', views.student_transcript, name='student_transcript'),
    
    # CBV URLs
    path('cbv/list/', views.EnrollmentListView.as_view(), name='enrollment_list_cbv'),
    path('cbv/<int:pk>/', views.EnrollmentDetailView.as_view(), name='enrollment_detail_cbv'),
    path('cbv/create/', views.EnrollmentCreateView.as_view(), name='enrollment_create_cbv'),
    path('cbv/<int:pk>/update/', views.EnrollmentUpdateView.as_view(), name='enrollment_update_cbv'),
    path('cbv/<int:pk>/delete/', views.EnrollmentDeleteView.as_view(), name='enrollment_delete_cbv'),
]

```

---

## ជំហានទី ៨៖ ការរៀបចំ Templates និង UI Design

### ៨.១ Master Layout: `templates/base.html`
ប្រើប្រាស់ Bootstrap 5, Khmer Font, និង Static Files Tag:

```html
{% load static %}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Student Management System{% endblock %}</title>
    <link rel="icon" type="image/x-icon" href="{% static 'images/favicon.ico' %}">
    <link rel="shortcut icon" type="image/x-icon" href="{% static 'images/favicon.ico' %}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{% static 'css/style.css' %}">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.3rem;
        }
        .card {
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,.1);
            margin-bottom: 20px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }
    </style>
    {% block extra_css %}{% endblock %}
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="{% url 'home' %}">📚 Student Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        {% if user.is_authenticated and not user.is_staff and user.student %}
                            <a class="nav-link" href="{% url 'students:student_detail' user.student.pk %}">My Profile</a>
                        {% else %}
                            <a class="nav-link" href="{% url 'students:student_list' %}">Students</a>
                        {% endif %}
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{% url 'courses:course_list' %}">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{% url 'enrollments:enrollment_list' %}">Enrollments</a>
                    </li>
                    {% if user.is_authenticated %}
                    {% if user.is_staff %}
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/">Admin Panel</a>
                    </li>
                    {% endif %}
                    <li class="nav-item dropdown ms-lg-2">
                        <a class="nav-link dropdown-toggle btn btn-sm btn-outline-light text-white px-3" href="#" role="button" data-bs-toggle="dropdown">
                            👤 {{ user.username }}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                            <li><span class="dropdown-item-text text-muted small">{{ user.email|default:"No email" }}</span></li>
                            {% if user.student %}
                            <li><a class="dropdown-item" href="{% url 'students:student_detail' user.student.pk %}">👤 My Profile</a></li>
                            <li><a class="dropdown-item" href="{% url 'enrollments:student_transcript' user.student.student_id %}">📄 My Transcript</a></li>
                            {% endif %}
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="{% url 'logout' %}"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                    {% else %}
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link btn btn-sm btn-outline-light text-white px-3 me-2" href="{% url 'login' %}">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-sm btn-light text-primary fw-bold px-3" href="{% url 'students:register' %}">Register</a>
                    </li>
                    {% endif %}
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        {% if messages %}
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            {% for message in messages %}
                <div>{{ message }}</div>
            {% endfor %}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        {% endif %}

        {% block content %}{% endblock %}
    </div>

    <footer class="bg-light text-center py-4 mt-5">
        <p class="text-muted">© 2026 Build Bright University - Student Management System</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="{% static 'js/main.js' %}"></script>
    {% block extra_js %}{% endblock %}
</body>
</html>
```

### ៨.២ Master Layout: `templates/base.html`
```html
{% extends 'base.html' %}

{% block title %}Home - Student Management System{% endblock %}

{% block content %}
<div class="jumbotron bg-light p-5 rounded">
    <h1 class="display-4">📚 ប្រព័ន្ធគ្រប់គ្រងនិស្សិត</h1>
    <p class="lead">Student Management System by Build Bright University</p>
    <hr class="my-4">
    <p>ស្វាគមន៍ដល់ប្រព័ន្ធគ្រប់គ្រងនិស្សិតដែលប្រើ Django Framework។</p>
</div>

<div class="row mt-5">
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <div class="card-body text-center">
                <h5 class="card-title">👥 សិស្ស</h5>
                <h2 class="text-primary">{{ total_students }}</h2>
                <p class="text-muted">សិស្សសរុប</p>
            </div>
            <div class="card-footer">
                {% if user.is_authenticated and not user.is_staff and user.student %}
                <a href="{% url 'students:student_detail' user.student.pk %}" class="btn btn-sm btn-primary">មើលប្រវត្តិរូបខ្ញុំ</a>
                {% else %}
                <a href="{% url 'students:student_list' %}" class="btn btn-sm btn-primary">មើលលម្អិត</a>
                {% endif %}
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <div class="card-body text-center">
                <h5 class="card-title">📖 វគ្គ</h5>
                <h2 class="text-success">{{ total_courses }}</h2>
                <p class="text-muted">វគ្គសរុប</p>
            </div>
            <div class="card-footer">
                <a href="{% url 'courses:course_list' %}" class="btn btn-sm btn-success">មើលលម្អិត</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <div class="card-body text-center">
                <h5 class="card-title">✍️ ការចុះឈ្មោះ</h5>
                <h2 class="text-info">{{ total_enrollments }}</h2>
                <p class="text-muted">ការចុះឈ្មោះសរុប</p>
            </div>
            <div class="card-footer">
                <a href="{% url 'enrollments:enrollment_list' %}" class="btn btn-sm btn-info">មើលលម្អិត</a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <div class="card-body text-center">
                <h5 class="card-title">⚙️ Admin</h5>
                <h2 class="text-warning">🔧</h2>
                <p class="text-muted">ផ្ទាំងគ្រប់គ្រង</p>
            </div>
            <div class="card-footer">
                <a href="/admin/" class="btn btn-sm btn-warning">ចូលគ្រប់គ្រង</a>
            </div>
        </div>
    </div>
</div>

<!-- Demo Test Accounts for All 3 Roles -->
<div class="row mt-4 mb-2">
    <div class="col-12">
        <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #f8f9ff 0%, #edf2f7 100%);">
            <div class="card-body p-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between mb-3 pb-2 border-bottom">
                    <div class="d-flex align-items-center">
                        <span class="fs-1 me-3">🔑</span>
                        <div>
                            <h3 class="mb-1 fw-bold text-dark">គណនីសាកល្បងតាមតួនាទីទាំង ៣ (Demo Test Accounts for All 3 Roles)</h3>
                            <p class="text-muted mb-0 small">
                                សាកល្បងសិទ្ធិប្រើប្រាស់ និងប្រព័ន្ធការពារសុវត្ថិភាព (Role-Based Access Control) រវាង Admin, Teacher, និង Student:
                            </p>
                        </div>
                    </div>
                    <span class="badge bg-primary px-3 py-2 mt-2 mt-md-0">BBU RBAC System</span>
                </div>

                <div class="row g-4 pt-2">
                    {% for acc in test_accounts %}
                    <div class="col-lg-4 col-md-6">
                        <div class="card h-100 shadow-sm border {{ acc.border_class }} bg-white">
                            <div class="card-header bg-white border-0 pt-3 pb-1 d-flex justify-content-between align-items-center">
                                <span class="fs-3">{{ acc.icon }}</span>
                                <span class="badge {{ acc.badge_class }} py-2 px-3 fw-semibold">{{ acc.badge }}</span>
                            </div>
                            <div class="card-body d-flex flex-column">
                                <h5 class="fw-bold mb-2">{{ acc.role_title }}</h5>
                                <p class="text-muted small mb-3">{{ acc.description }}</p>

                                <div class="bg-light p-3 rounded mb-3 border">
                                    <div class="d-flex justify-content-between align-items-center mb-2 pb-1 border-bottom">
                                        <span class="text-secondary small fw-bold">Username:</span>
                                        <div class="d-flex align-items-center">
                                            <code class="fs-6 fw-bold text-dark me-2">{{ acc.username }}</code>
                                            <button type="button" class="btn btn-outline-secondary btn-sm py-0 px-2" onclick="copyToClipboard('{{ acc.username }}', this)" title="Copy username">📋 Copy</button>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-secondary small fw-bold">Password:</span>
                                        <div class="d-flex align-items-center">
                                            <code class="fs-6 fw-bold text-dark me-2">{{ acc.password }}</code>
                                            <button type="button" class="btn btn-outline-secondary btn-sm py-0 px-2" onclick="copyToClipboard('{{ acc.password }}', this)" title="Copy password">📋 Copy</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3 flex-grow-1">
                                    <strong class="small text-muted d-block mb-1">វិសាលភាពសិទ្ធិ (Access Scope):</strong>
                                    <ul class="list-unstyled small mb-0">
                                        {% for s in acc.scope %}
                                        <li class="mb-1 text-secondary">
                                            <i class="fas fa-check-circle text-success me-1"></i> {{ s }}
                                        </li>
                                        {% endfor %}
                                    </ul>
                                </div>

                                <div class="mt-auto pt-2">
                                    {% if user.is_authenticated and user.username == acc.username %}
                                    <div class="alert alert-success py-2 text-center small mb-0">
                                        ✅ កំពុង Login ជាមួយគណនីនេះ (Active)
                                    </div>
                                    {% else %}
                                    <a href="{{ acc.login_url }}" class="btn {{ acc.btn_class }} btn-sm w-100 py-2 fw-semibold">
                                        {{ acc.button_text }} &rarr;
                                    </a>
                                    {% endif %}
                                </div>
                            </div>
                        </div>
                    </div>
                    {% endfor %}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-4">
        <h3>📊 ស្ថានភាព</h3>
        <ul class="list-group">
            <li class="list-group-item">
                <strong>សិស្សដែលសកម្ម:</strong> {{ active_students }}
            </li>
            <li class="list-group-item">
                <strong>វគ្គដែលសកម្ម:</strong> {{ active_courses }}
            </li>
        </ul>
    </div>
    
    <div class="col-md-8">
        <h3>🎯 ដូចម្តេច ចាប់ផ្តើម</h3>
        <div class="alert alert-info">
            <h5>ត្រើងយល់ដឹង ប្រព័ន្ធគ្រប់គ្រងនិស្សិត:</h5>
            <ol>
                <li>ចូលក្នុង Admin Panel សម្រាប់ management ពេញលេញ</li>
                <li>ឆ្លើយ Students, Courses, Enrollments pages</li>
                <li>សាកល្បង REST API នៅលើ /api/ URL</li>
                <li>អានឯកសារលម្អិតក្នុងថត lessons/ (INSTRUCTIONS_KH.md) សម្រាប់ព័ត៌មានបន្ថែម</li>
                <li>ធ្វើលំហាត់ក្នុងថត lessons/ (PRACTICE_EXERCISES_KH.md) ដើម្បីរៀនអនុវត្តជាក់ស្តែង</li>
            </ol>
        </div>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-12">
        <h3>🔗 ឯកសារមានប្រយោជន៍</h3>
        <ul>
            <li><a href="https://docs.djangoproject.com/" target="_blank">Django Documentation</a></li>
            <li><a href="https://www.django-rest-framework.org/" target="_blank">Django REST Framework</a></li>
            <li><a href="https://getbootstrap.com/" target="_blank">Bootstrap Documentation</a></li>
        </ul>
    </div>
</div>
{% endblock %}

{% block extra_js %}
<script>
function copyToClipboard(text, btn) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(function() {
            showCopiedFeedback(btn);
        }).catch(function(err) {
            fallbackCopy(text, btn);
        });
    } else {
        fallbackCopy(text, btn);
    }
}

function fallbackCopy(text, btn) {
    const tempInput = document.createElement('input');
    tempInput.value = text;
    document.body.appendChild(tempInput);
    tempInput.select();
    document.execCommand('copy');
    document.body.removeChild(tempInput);
    showCopiedFeedback(btn);
}

function showCopiedFeedback(btn) {
    const originalText = btn.innerHTML;
    btn.innerHTML = '✅ Copied!';
    btn.classList.remove('btn-outline-secondary');
    btn.classList.add('btn-success');
    setTimeout(function() {
        btn.innerHTML = originalText;
        btn.classList.remove('btn-success');
        btn.classList.add('btn-outline-secondary');
    }, 1500);
}
</script>
{% endblock %}
```
### ៨.៣ Master Layout: `templates/403.html`
```html
{% extends 'base.html' %}

{% block title %}403 Forbidden - Access Denied{% endblock %}

{% block content %}
<div class="row justify-content-center my-5">
    <div class="col-md-8 col-lg-6 text-center">
        <div class="card shadow-sm border-0 p-5">
            <div class="mb-4">
                <span style="font-size: 4rem;">🔒</span>
            </div>
            <h1 class="display-6 fw-bold text-danger mb-2">403 - ការអនុញ្ញាតត្រូវបានបដិសេធ</h1>
            <h4 class="text-secondary mb-3">Access Forbidden / Access Denied</h4>
            <p class="text-muted mb-4">
                {{ exception|default:"អ្នកមិនមានសិទ្ធិគ្រប់គ្រាន់ដើម្បីចូលមើល កែប្រែ ឬលុបទិន្នន័យនេះឡើយ។ ប្រសិនបើអ្នកជានិស្សិត អ្នកអាចមើលនិងកែប្រែបានតែប្រវត្តិរូបផ្ទាល់ខ្លួនរបស់អ្នកប៉ុណ្ណោះ។" }}
            </p>
            <p class="small text-muted mb-4">
                You do not have permission to access, edit, or delete this record. Student accounts can only manage their own profile.
            </p>
            <div class="d-flex justify-content-center gap-3">
                {% if user.is_authenticated and user.student %}
                <a href="{% url 'students:student_detail' user.student.pk %}" class="btn btn-primary px-4">
                    👤 ទៅកាន់ប្រវត្តិរូបខ្ញុំ (My Profile)
                </a>
                {% endif %}
                <a href="{% url 'home' %}" class="btn btn-outline-secondary px-4">
                    🏠 ទំព័រដើម (Home)
                </a>
            </div>
        </div>
    </div>
</div>
{% endblock %}

```

### ៨.៤ Student Page: `templates/students/student_list.html`
រចនាតារាងដោយបំបែកជាពីរជួរឈ្មោះ (ឈ្មោះខ្មែរ + ឈ្មោះអង់គ្លេស) និងរូបថត Avatar៖

```html
{% extends 'base.html' %}

{% block title %}Students - Student Management System{% endblock %}

{% block content %}
<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="mb-1">🎓 Students Directory / បញ្ជីឈ្មោះនិស្សិត</h2>
        <p class="text-muted mb-0">Manage registered students, view transcripts, and academic performance</p>
    </div>
    <div class="col-md-4 text-end">
        {% if user.is_staff %}
        <a href="{% url 'students:register' %}" class="btn btn-primary shadow-sm">
            <i class="fas fa-user-plus me-1"></i> ➕ Add New Student
        </a>
        {% endif %}
    </div>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body p-4">
        <form method="get" class="mb-4">
            <div class="input-group">
                <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                <input type="text" name="q" class="form-control" placeholder="Search by Student ID, Khmer Name, Latin Name, or Email..." value="{{ search_query }}">
                <button class="btn btn-primary px-4" type="submit">Search</button>
                {% if search_query %}
                <a href="{% url 'students:student_list' %}" class="btn btn-outline-secondary">Clear</a>
                {% endif %}
            </div>
        </form>

        {% if students %}
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="text-center" style="width: 50px;">#</th>
                        <th class="text-center" style="width: 65px;">Photo</th>
                        <th style="min-width: 140px;">Student ID</th>
                        <th style="min-width: 180px;">Khmer Name</th>
                        <th style="min-width: 170px;">English Name</th>
                        <th style="min-width: 200px;">Email</th>
                        <th style="min-width: 130px;">City</th>
                        <th class="text-center" style="width: 80px;">GPA</th>
                        <th class="text-center" style="width: 90px;">Status</th>
                        <th class="text-end" style="min-width: 170px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {% for student in students %}
                    <tr>
                        <!-- 1st Column: Index -->
                        <td class="text-center text-muted fw-semibold">
                            {% if page_obj %}
                                {{ page_obj.start_index|add:forloop.counter0 }}
                            {% else %}
                                {{ forloop.counter }}
                            {% endif %}
                        </td>

                        <!-- 2nd Column: Student Picture Avatar (after index) -->
                        <td class="text-center">
                            <a href="{% url 'students:student_detail' student.pk %}">
                                {% if student.profile_picture %}
                                    <img src="{{ student.profile_picture.url }}" alt="{{ student.get_primary_name }}" class="rounded-circle shadow-sm border" width="40" height="40" style="object-fit: cover;">
                                {% else %}
                                    <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center fw-bold shadow-sm" style="width: 40px; height: 40px; font-size: 0.95rem;">
                                        {% if student.khmer_name %}
                                            {{ student.khmer_name|slice:":1" }}
                                        {% elif student.user.first_name %}
                                            {{ student.user.first_name|slice:":1" }}
                                        {% else %}
                                            👤
                                        {% endif %}
                                    </div>
                                {% endif %}
                            </a>
                        </td>

                        <!-- Student ID -->
                        <td>
                            <a href="{% url 'students:student_detail' student.pk %}" class="fw-bold text-decoration-none text-dark">
                                {{ student.student_id }}
                            </a>
                        </td>

                        <!-- Name Column 1: Khmer Name (Primary) -->
                        <td>
                            <strong class="text-primary fs-6">{{ student.khmer_name|default:student.user.get_full_name }}</strong>
                        </td>

                        <!-- Name Column 2: English Name -->
                        <td>
                            <span class="text-secondary">{{ student.user.get_full_name|default:student.user.username }}</span>
                        </td>

                        <!-- Email -->
                        <td class="text-muted small">
                            {{ student.user.email }}
                        </td>

                        <!-- City -->
                        <td class="small">
                            {{ student.city }}
                        </td>

                        <!-- GPA -->
                        <td class="text-center">
                            {% if student.gpa >= 3.5 %}
                                <span class="badge bg-success px-2 py-1">{{ student.gpa }}</span>
                            {% elif student.gpa >= 3.0 %}
                                <span class="badge bg-primary px-2 py-1">{{ student.gpa }}</span>
                            {% elif student.gpa >= 2.0 %}
                                <span class="badge bg-info text-dark px-2 py-1">{{ student.gpa }}</span>
                            {% else %}
                                <span class="badge bg-secondary px-2 py-1">{{ student.gpa }}</span>
                            {% endif %}
                        </td>

                        <!-- Status -->
                        <td class="text-center">
                            {% if student.is_active %}
                                <span class="badge bg-success">Active</span>
                            {% else %}
                                <span class="badge bg-secondary">Inactive</span>
                            {% endif %}
                        </td>

                        <!-- Actions -->
                        <td class="text-end text-nowrap">
                            <a href="{% url 'students:student_detail' student.pk %}" class="btn btn-sm btn-info text-white" title="View Student">View</a>
                            {% if user.is_staff or user == student.user %}
                            <a href="{% url 'students:student_update' student.pk %}" class="btn btn-sm btn-warning" title="Edit Student">Edit</a>
                            {% endif %}
                            {% if user.is_staff %}
                            <a href="{% url 'students:student_delete' student.pk %}" class="btn btn-sm btn-danger" title="Delete Student">Delete</a>
                            {% endif %}
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>

        <!-- Pagination Navigation -->
        {% if page_obj and page_obj.has_other_pages %}
        <nav aria-label="Student page navigation" class="mt-4">
            <ul class="pagination justify-content-center mb-0">
                {% if page_obj.has_previous %}
                <li class="page-item">
                    <a class="page-link" href="?page=1{% if search_query %}&q={{ search_query }}{% endif %}">&laquo; First</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?page={{ page_obj.previous_page_number }}{% if search_query %}&q={{ search_query }}{% endif %}">Previous</a>
                </li>
                {% else %}
                <li class="page-item disabled"><span class="page-link">&laquo; First</span></li>
                <li class="page-item disabled"><span class="page-link">Previous</span></li>
                {% endif %}

                <li class="page-item active">
                    <span class="page-link">Page {{ page_obj.number }} of {{ page_obj.paginator.num_pages }} ({{ page_obj.paginator.count }} students)</span>
                </li>

                {% if page_obj.has_next %}
                <li class="page-item">
                    <a class="page-link" href="?page={{ page_obj.next_page_number }}{% if search_query %}&q={{ search_query }}{% endif %}">Next</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?page={{ page_obj.paginator.num_pages }}{% if search_query %}&q={{ search_query }}{% endif %}">Last &raquo;</a>
                </li>
                {% else %}
                <li class="page-item disabled"><span class="page-link">Next</span></li>
                <li class="page-item disabled"><span class="page-link">Last &raquo;</span></li>
                {% endif %}
            </ul>
        </nav>
        {% endif %}

        {% else %}
        <div class="alert alert-info mb-0">
            No students found. <a href="{% url 'students:register' %}">Register a new student</a>
        </div>
        {% endif %}
    </div>
</div>
{% endblock %}

```

---

## ជំហានទី ៩៖ ការរៀបចំ Static Files & Media Files

### ៩.១ Static CSS: `static/css/style.css`
```css
/* Build Bright University (BBU) - Custom Static Stylesheet */

:root {
    --bbu-primary: #1e3c72;
    --bbu-secondary: #2a5298;
    --bbu-accent: #667eea;
    --bbu-gold: #f6d365;
}

/* Khmer Font enhancements */
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Kantumruy Pro", "Battambang", sans-serif;
    background-color: #f8fafc;
    color: #1e293b;
}

/* Custom Gradient Header */
.bbu-gradient-header {
    background: linear-gradient(135deg, var(--bbu-primary) 0%, var(--bbu-secondary) 100%);
    color: #ffffff;
}

/* Student Avatar Styles */
.student-avatar-thumb {
    width: 44px;
    height: 44px;
    object-fit: cover;
    border-radius: 50%;
    border: 2px solid #e2e8f0;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.student-avatar-placeholder {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background-color: #e2e8f0;
    color: #64748b;
    font-size: 1.1rem;
    font-weight: 600;
}

/* Smooth card shadows */
.card-bbu {
    border: none;
    border-radius: 10px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card-bbu:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -4px rgba(0, 0, 0, 0.04);
}

```

### ៩.២ Static JS: `static/js/main.js`
```javascript
/**
 * Build Bright University (BBU) - Main Static JavaScript
 * Provides UI interactivity, auto-dismiss alerts, and tooltips.
 */

document.addEventListener('DOMContentLoaded', function () {
    // Auto-dismiss alert messages after 5 seconds
    const alerts = document.querySelectorAll('.alert.alert-dismissible');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            alert.style.transition = 'opacity 0.6s ease';
            alert.style.opacity = '0';
            setTimeout(function () {
                alert.remove();
            }, 600);
        }, 5000);
    });

    // Console confirmation of static JS loaded
    console.log('✅ BBU Student Management System - Static assets loaded successfully.');
});

```

---

## ជំហានទី ១០៖ ការកំណត់ Django Admin Panel

នៅក្នុង `students/admin.py` យើងកំណត់ Display, Filter, និង Search Field ឱ្យស្វែងរកតាមឈ្មោះខ្មែរបាន៖

```python
from django.contrib import admin
from .models import Student

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    """Admin interface for Student model"""
    
    list_display = ['student_id', 'khmer_name', 'get_full_name', 'gender', 'city', 'gpa', 'is_active', 'enrollment_date']
    list_filter = ['is_active', 'gender', 'city', 'enrollment_date']
    search_fields = ['student_id', 'khmer_name', 'user__username', 'user__first_name', 'user__last_name', 'user__email']
    readonly_fields = ['enrollment_date', 'created_at', 'updated_at']
    
    fieldsets = (
        ('User & Identity Information', {
            'fields': ('user', 'student_id', 'khmer_name')
        }),
        ('Personal Information', {
            'fields': ('date_of_birth', 'gender', 'phone_number', 'profile_picture')
        }),
        ('Address Information', {
            'fields': ('address', 'city', 'country')
        }),
        ('Academic Information', {
            'fields': ('gpa', 'is_active')
        }),
        ('Dates', {
            'fields': ('enrollment_date', 'created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
    
    def get_full_name(self, obj):
        """Display full name from related User"""
        return obj.user.get_full_name()
    get_full_name.short_description = 'Full Name'

```

---

## ជំហានទី ១១៖ ការបង្កើត REST API ជាមួយ DRF

### ១១.១ Serializers: `student_system/serializers.py`
```python
from rest_framework import serializers
from students.models import Student
from courses.models import Course
from enrollments.models import Enrollment
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):
    """Serializer for User model"""
    class Meta:
        model = User
        fields = ['id', 'username', 'first_name', 'last_name', 'email']

class StudentSerializer(serializers.ModelSerializer):
    """Serializer for Student model"""
    user = UserSerializer(read_only=True)
    user_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(), source='user', write_only=True, required=False
    )
    
    class Meta:
        model = Student
        fields = ['id', 'user', 'user_id', 'student_id', 'khmer_name', 'date_of_birth', 'gender', 
                  'phone_number', 'address', 'city', 'country', 'profile_picture', 'gpa', 
                  'is_active', 'enrollment_date']
        read_only_fields = ['enrollment_date']

class CourseSerializer(serializers.ModelSerializer):
    """Serializer for Course model"""
    instructor = UserSerializer(read_only=True)
    instructor_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(), source='instructor', write_only=True, required=False, allow_null=True
    )
    enrollment_count = serializers.SerializerMethodField()
    
    class Meta:
        model = Course
        fields = ['id', 'code', 'title', 'description', 'instructor', 'instructor_id',
                  'credits', 'level', 'capacity', 'status', 'start_date', 
                  'end_date', 'enrollment_count']
    
    def get_enrollment_count(self, obj):
        return obj.enrollments.count()

class EnrollmentSerializer(serializers.ModelSerializer):
    """Serializer for Enrollment model"""
    student = StudentSerializer(read_only=True)
    course = CourseSerializer(read_only=True)
    student_id = serializers.PrimaryKeyRelatedField(
        queryset=Student.objects.all(), source='student', write_only=True
    )
    course_id = serializers.PrimaryKeyRelatedField(
        queryset=Course.objects.all(), source='course', write_only=True
    )
    
    class Meta:
        model = Enrollment
        fields = ['id', 'student', 'course', 'student_id', 'course_id', 'status', 'grade', 'score', 
                  'attendance_percentage', 'notes', 'enrollment_date', 'completed_date']
        read_only_fields = ['enrollment_date']

class EnrollmentDetailSerializer(serializers.ModelSerializer):
    """Detailed serializer for Enrollment including student and course info"""
    student_id = serializers.CharField(source='student.student_id', read_only=True)
    course_code = serializers.CharField(source='course.code', read_only=True)
    course_title = serializers.CharField(source='course.title', read_only=True)
    
    class Meta:
        model = Enrollment
        fields = ['id', 'student_id', 'course_code', 'course_title', 'status', 
                  'grade', 'score', 'attendance_percentage', 'notes', 
                  'enrollment_date', 'completed_date']

```

### ១១.២ API ViewSets: `student_system/api_views.py`
```python
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from students.models import Student
from courses.models import Course
from enrollments.models import Enrollment
from student_system.serializers import StudentSerializer, CourseSerializer, EnrollmentSerializer, EnrollmentDetailSerializer

class StudentViewSet(viewsets.ModelViewSet):
    """ViewSet for Student API endpoints"""
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['is_active', 'gender', 'city']
    search_fields = ['student_id', 'khmer_name', 'user__username', 'user__first_name', 'user__last_name']
    ordering_fields = ['student_id', 'enrollment_date', 'gpa']
    ordering = ['student_id']
    
    def perform_create(self, serializer):
        if 'user' not in serializer.validated_data:
            serializer.save(user=self.request.user)
        else:
            serializer.save()
    
    @action(detail=True, methods=['get'])
    def enrollments(self, request, pk=None):
        """Get all enrollments for a specific student"""
        student = self.get_object()
        enrollments = student.enrollments.all()
        serializer = EnrollmentSerializer(enrollments, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def transcript(self, request, pk=None):
        """Get academic transcript for a student"""
        student = self.get_object()
        enrollments = student.enrollments.filter(status='COMPLETED')
        
        total_score = sum([e.score or 0 for e in enrollments if e.score])
        average_score = total_score / len(enrollments) if enrollments else 0
        
        data = {
            'student_id': student.student_id,
            'student_name': student.user.get_full_name(),
            'total_courses': student.enrollments.count(),
            'completed_courses': enrollments.count(),
            'average_score': round(average_score, 2),
            'gpa': float(student.gpa),
            'enrollments': EnrollmentDetailSerializer(enrollments, many=True).data
        }
        return Response(data)

class CourseViewSet(viewsets.ModelViewSet):
    """ViewSet for Course API endpoints"""
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    filterset_fields = ['status', 'level']
    search_fields = ['code', 'title', 'instructor__username']
    ordering_fields = ['code', 'start_date', 'capacity']
    ordering = ['code']
    
    @action(detail=True, methods=['get'])
    def enrollments(self, request, pk=None):
        """Get all enrollments for a specific course"""
        course = self.get_object()
        enrollments = course.enrollments.all()
        serializer = EnrollmentSerializer(enrollments, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def students(self, request, pk=None):
        """Get all students enrolled in a course"""
        course = self.get_object()
        students = Student.objects.filter(enrollments__course=course).distinct()
        serializer = StudentSerializer(students, many=True)
        return Response(serializer.data)
    
    @action(detail=True, methods=['get'])
    def enrollment_statistics(self, request, pk=None):
        """Get enrollment statistics for a course"""
        course = self.get_object()
        enrollments = course.enrollments.all()
        
        data = {
            'course_code': course.code,
            'course_title': course.title,
            'total_capacity': course.capacity,
            'total_enrolled': enrollments.filter(status='ENROLLED').count(),
            'total_completed': enrollments.filter(status='COMPLETED').count(),
            'total_dropped': enrollments.filter(status='DROPPED').count(),
            'average_score': enrollments.filter(score__isnull=False).values('score').aggregate(avg=__import__('django.db.models', fromlist=['Avg']).Avg('score'))['avg'] or 0,
        }
        return Response(data)

class EnrollmentViewSet(viewsets.ModelViewSet):
    """ViewSet for Enrollment API endpoints"""
    queryset = Enrollment.objects.all()
    serializer_class = EnrollmentSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['status', 'student__student_id', 'course__code']
    search_fields = ['student__student_id', 'course__code', 'student__user__username']
    ordering_fields = ['enrollment_date', 'score', 'status']
    ordering = ['-enrollment_date']
    
    @action(detail=True, methods=['post'])
    def submit_grade(self, request, pk=None):
        """Submit or update grade for an enrollment"""
        enrollment = self.get_object()
        
        if 'score' in request.data:
            enrollment.score = request.data['score']
        
        if 'attendance_percentage' in request.data:
            enrollment.attendance_percentage = request.data['attendance_percentage']
        
        if 'notes' in request.data:
            enrollment.notes = request.data['notes']
        
        enrollment.save()
        serializer = self.get_serializer(enrollment)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def complete_enrollment(self, request, pk=None):
        """Mark an enrollment as completed"""
        enrollment = self.get_object()
        enrollment.status = 'COMPLETED'
        enrollment.completed_date = __import__('django.utils.timezone', fromlist=['now']).now().date()
        enrollment.save()
        serializer = self.get_serializer(enrollment)
        return Response(serializer.data)

```

### ១១.៣ API Routers: `student_system/api_urls.py`
```python
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from student_system.api_views import StudentViewSet, CourseViewSet, EnrollmentViewSet

# Create router and register viewsets
router = DefaultRouter()
router.register(r'students', StudentViewSet, basename='student')
router.register(r'courses', CourseViewSet, basename='course')
router.register(r'enrollments', EnrollmentViewSet, basename='enrollment')

app_name = 'api'

urlpatterns = [
    path('', include(router.urls)),
]

```

---

## ជំហានទី ១២៖ ការបង្កើត Data Seeding Script និង Automated Testing

### ១២.១ Seeding 1,000+ Khmer Students: `scripts/generate_khmer_data.py`
ដំណើរការបង្កើតទិន្នន័យគំរូសិស្សកម្ពុជា ១,០០០ នាក់ មុខវិជ្ជា ២៥ មុខ និងការចុះឈ្មោះ ៣,០០០+ Records៖
```python
#!/usr/bin/env python
"""
Build Bright University (BBU) - Khmer Data Generator
Generates realistic Cambodian student profiles, IT courses, and course enrollments.
Target: 1,000+ students, 25 IT courses, 3,000+ enrollments.
"""

import os
import sys
import random
from datetime import date, timedelta
from decimal import Decimal

# Setup Django environment
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'student_system.settings')
import django
django.setup()

from django.db import transaction
from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password
from students.models import Student
from courses.models import Course
from enrollments.models import Enrollment

# ==========================================
# Authentic Khmer Names & Data Dictionaries
# ==========================================

KHMER_LAST_NAMES = [
    ("Sok", "សុខ"), ("Chan", "ចាន់"), ("Chea", "ជា"), ("Heng", "ហេង"),
    ("Kim", "គីម"), ("Lim", "លីម"), ("Meng", "ម៉េង"), ("Pich", "ពេជ្រ"),
    ("Seng", "សេង"), ("Tep", "ទេព"), ("Vorn", "វ៉ន"), ("Yim", "យីម"),
    ("Ros", "រស់"), ("Keo", "កែវ"), ("Chhorn", "ឈន"), ("Ouk", "អ៊ុក"),
    ("Prak", "ប្រាក់"), ("San", "សាន"), ("Meas", "មាស"), ("Nget", "ង៉ែត"),
    ("Som", "សោម"), ("Duong", "ដួង"), ("Kong", "គង់"), ("Long", "ឡុង"),
    ("Sarun", "សារុន"), ("Khun", "ឃុន"), ("Bun", "ប៊ុន"), ("Ly", "លី"),
    ("Huy", "ហ៊ុយ"), ("Sin", "ស៊ីន"), ("Rath", "រ័ត្ន"), ("Phan", "ផាន់"),
    ("Sam", "សំ"), ("Touch", "ទូច"), ("Srun", "ស្រ៊ុន"), ("Em", "អ៊ឹម"),
    ("Roeun", "រឿន"), ("Chhum", "ឈុំ"), ("Nov", "ណុវ"), ("Pao", "ប៉ោ"),
    ("Hun", "ហ៊ុន"), ("Chhay", "ឆាយ"), ("Mao", "ម៉ៅ"), ("Khem", "ខែម"),
    ("Krouch", "ក្រូច"), ("Chrun", "ជ្រុន"), ("Taing", "តាំង"), ("Soeun", "សឿន")
]

KHMER_MALE_FIRST_NAMES = [
    ("Dara", "តារា"), ("Vichea", "វិជ្ជា"), ("Rithy", "រិទ្ធី"), ("Serey", "សិរី"),
    ("Kosal", "កុសល"), ("Vibol", "វិបុល"), ("Bunthoeun", "ប៊ុនធឿន"), ("Sovann", "សុវណ្ណ"),
    ("Chamroeun", "ចំរើន"), ("Makara", "មករា"), ("Piseth", "ពិសិដ្ឋ"), ("Sambath", "សម្បត្តិ"),
    ("Thavrak", "ថាវរ៉ាក់"), ("Veasna", "វាសនា"), ("Visal", "វិសាល"), ("Pharith", "ផារិទ្ធ"),
    ("Bora", "បូរ៉ា"), ("Khemara", "ខេមរា"), ("Rattanak", "រតនៈ"), ("Samnang", "សំណាង"),
    ("Sophea", "សុភា"), ("Seyha", "សីហា"), ("Oudom", "ឧត្តម"), ("Panha", "បញ្ញា"),
    ("Phearith", "ភារិទ្ធ"), ("Moni", "មុនី"), ("Vichet", "វិចិត្រ"), ("Reaksmey", "រស្មី"),
    ("Seyla", "សិលា"), ("Channarith", "ច័ន្ទណារិទ្ធ"), ("Davit", "ដាវីត"), ("Rathana", "រតនា"),
    ("Virak", "វីរៈ"), ("Sovanreach", "សុវណ្ណរាជ"), ("Roth", "រ័ត្ន"), ("Vireak", "វីរៈ")
]

KHMER_FEMALE_FIRST_NAMES = [
    ("Bopha", "បុប្ផា"), ("Channary", "ច័ន្ទណារី"), ("Dany", "ដានី"), ("Kolab", "កុលាប"),
    ("Malis", "ម្លិះ"), ("Phalla", "ផល្លា"), ("Rachana", "រចនា"), ("Sreymom", "ស្រីមុំ"),
    ("Thida", "ធីតា"), ("Vanny", "វ៉ាន់នី"), ("Neary", "នារី"), ("Kanha", "កញ្ញា"),
    ("Sreypov", "ស្រីពៅ"), ("Leakhena", "លក្ខិណា"), ("Chanlina", "ច័ន្ទលីណា"), ("Sophorn", "សោភ័ណ"),
    ("Chenda", "ចិន្តា"), ("Kunthea", "គន្ធា"), ("Monika", "ម៉ូនីកា"), ("Sotheavy", "សុធាវី"),
    ("Bophary", "បុប្ផារី"), ("Chanthou", "ច័ន្ទធូ"), ("Devi", "ទេវី"), ("Kalyan", "កល្យាណ"),
    ("Nita", "នីតា"), ("Sreynich", "ស្រីនិច"), ("Theary", "ធារី"), ("Voleak", "វល័ក្ខ"),
    ("Pisey", "ពិសី"), ("Sreyneat", "ស្រីនាត"), ("Chanthy", "ច័ន្ទធី"), ("Romdoul", "រំដួល")
]

CAMBODIAN_CITIES = [
    ("Phnom Penh", "រាជធានីភ្នំពេញ"),
    ("Siem Reap", "ខេត្តសៀមរាប"),
    ("Battambang", "ខេត្តបាត់ដំបង"),
    ("Kandal", "ខេត្តកណ្តាល"),
    ("Kampong Cham", "ខេត្តកំពង់ចាម"),
    ("Kampot", "ខេត្តកំពត"),
    ("Preah Sihanouk", "ខេត្តព្រះសីហនុ"),
    ("Takeo", "ខេត្តតាកែវ"),
    ("Prey Veng", "ខេត្តព្រៃវែង"),
    ("Kampong Thom", "ខេត្តកំពង់ធំ"),
    ("Kampong Speu", "ខេត្តកំពង់ស្ពឺ"),
    ("Pursat", "ខេត្តពោធិ៍សាត់"),
    ("Svay Rieng", "ខេត្តស្វាយរៀង"),
    ("Banteay Meanchey", "ខេត្តបន្ទាយមានជ័យ"),
    ("Kratie", "ខេត្តក្រចេះ")
]

KHMER_STREET_ADDRESSES = [
    "Sangkat Boeung Keng Kang 1, Khan Chamkarmon",
    "Sangkat Teuk Laak 1, Khan Toul Kork",
    "Sangkat Phsar Thmei 3, Khan Daun Penh",
    "Sangkat Kakab 1, Khan Por Sen Chey",
    "Sangkat Chroy Changvar, Khan Chroy Changvar",
    "Sangkat Toul Svay Prey 1, Khan Boeng Keng Kang",
    "Sangkat Phnom Penh Thmei, Khan Sen Sok",
    "Sangkat Svay Dangkum, Krong Siem Reap",
    "Sangkat Sala Kamreuk, Krong Siem Reap",
    "Sangkat Svay Por, Krong Battambang",
    "Sangkat Ratanak, Krong Battambang",
    "Sangkat Veal Vong, Krong Kampong Cham",
    "Sangkat Kampong Kandal, Krong Kampot",
    "Sangkat 4, Krong Preah Sihanouk",
    "Sangkat Roka Khnong, Krong Doun Kaev",
    "Sangkat Svay Rieng, Krong Svay Rieng"
]

PHONE_PREFIXES = [
    "010", "012", "015", "016", "017", "069", "070", "077", "078",
    "081", "086", "087", "089", "092", "093", "095", "096", "098", "099"
]

INSTRUCTORS_DATA = [
    ("dr_sok_piseth", "Piseth", "Sok (បណ្ឌិត សុខ ពិសិដ្ឋ)", "piseth.sok@bbu.edu.kh"),
    ("prof_heng_vichea", "Vichea", "Heng (សាស្ត្រាចារ្យ ហេង វិជ្ជា)", "vichea.heng@bbu.edu.kh"),
    ("dr_keo_dara", "Dara", "Keo (បណ្ឌិត កែវ តារា)", "dara.keo@bbu.edu.kh"),
    ("prof_chan_thavrak", "Thavrak", "Chan (សាស្ត្រាចារ្យ ចាន់ ថាវរ៉ាក់)", "thavrak.chan@bbu.edu.kh"),
    ("dr_meas_kanha", "Kanha", "Meas (បណ្ឌិត មាស កញ្ញា)", "kanha.meas@bbu.edu.kh"),
    ("prof_lim_vibol", "Vibol", "Lim (សាស្ត្រាចារ្យ លីម វិបុល)", "vibol.lim@bbu.edu.kh"),
    ("dr_tep_sovann", "Sovann", "Tep (បណ្ឌិត ទេព សុវណ្ណ)", "sovann.tep@bbu.edu.kh"),
    ("prof_pich_rachana", "Rachana", "Pich (សាស្ត្រាចារ្យ ពេជ្រ រចនា)", "rachana.pich@bbu.edu.kh"),
]

IT_COURSES_DATA = [
    # 100-Level Foundation Courses
    {
        "code": "CS101",
        "title": "Introduction to Computer Science (សេចក្តីផ្តើមវិទ្យាសាស្ត្រកុំព្យូទ័រ)",
        "description": "Fundamental concepts of computing, binary systems, algorithms, problem-solving, and computer ethics for IT freshmen at Build Bright University.",
        "credits": 3,
        "level": "100",
        "capacity": 45,
    },
    {
        "code": "IT102",
        "title": "Fundamentals of Information Technology (មូលដ្ឋានគ្រឹះព័ត៌មានវិទ្យា)",
        "description": "Overview of IT infrastructure, operating systems, hardware components, productivity suites, and modern office automation.",
        "credits": 3,
        "level": "100",
        "capacity": 50,
    },
    {
        "code": "CS103",
        "title": "Programming in C/C++ (ការសរសេរកម្មវិធីជាមួយ C/C++)",
        "description": "Structured programming principles, data types, pointers, memory allocation, control structures, and object-oriented foundations in C++.",
        "credits": 3,
        "level": "100",
        "capacity": 40,
    },
    {
        "code": "CS104",
        "title": "Computer Hardware & Architecture (ស្ថាបត្យកម្មនិងផ្នែករឹងកុំព្យូទ័រ)",
        "description": "CPU architecture, motherboard components, cache hierarchy, logic gates, peripheral buses, and PC assembly lab.",
        "credits": 3,
        "level": "100",
        "capacity": 40,
    },
    
    # 200-Level Core Technical Courses
    {
        "code": "WD201",
        "title": "Web Development I: HTML5, CSS3 & Modern JS (ការអភិវឌ្ឍគេហទំព័រ ១)",
        "description": "Responsive UI design, flexbox/grid layouts, Bootstrap 5 framework, and modern client-side JavaScript DOM manipulation.",
        "credits": 3,
        "level": "200",
        "capacity": 40,
    },
    {
        "code": "DB202",
        "title": "Database Systems & Relational SQL (ប្រព័ន្ធមូលដ្ឋានទិន្នន័យ និង SQL)",
        "description": "Relational schema design, normalization, complex SQL joins, indexing, transaction management, and SQLite/PostgreSQL usage.",
        "credits": 3,
        "level": "200",
        "capacity": 40,
    },
    {
        "code": "NET203",
        "title": "Computer Networking & Cisco CCNA Fundamentals (មូលដ្ឋានបណ្តាញកុំព្យូទ័រ)",
        "description": "OSI & TCP/IP models, IP subnetting, VLANs, routing protocols, switches, and practical packet tracer labs.",
        "credits": 3,
        "level": "200",
        "capacity": 35,
    },
    {
        "code": "CS204",
        "title": "Data Structures & Algorithm Design (ទម្រង់ទិន្នន័យ និងក្បួនដោះស្រាយ)",
        "description": "Linked lists, stacks, queues, binary search trees, hash tables, sorting algorithms, and Big-O computational complexity.",
        "credits": 3,
        "level": "200",
        "capacity": 35,
    },
    {
        "code": "PY205",
        "title": "Python Programming for Applications (ការសរសេរកម្មវិធី Python កម្រិតខ្ពស់)",
        "description": "Object-oriented Python, decorators, file I/O, regex, web scraping, and automated scripting for administrative tasks.",
        "credits": 3,
        "level": "200",
        "capacity": 40,
    },
    {
        "code": "OS206",
        "title": "Linux Server Administration (ការគ្រប់គ្រងប្រព័ន្ធប្រតិបត្តិការ Linux)",
        "description": "Linux terminal mastery, bash shell scripting, user permissions, systemd services, SSH hardening, and Apache/Nginx web server setup.",
        "credits": 3,
        "level": "200",
        "capacity": 35,
    },

    # 300-Level Advanced Application Development
    {
        "code": "WD301",
        "title": "Web Development II: Django Framework & REST APIs (គេហទំព័រ Django & APIs)",
        "description": "Backend engineering with Django 4.2+, MVT architecture, Django REST Framework, token authentication, and full-stack integration.",
        "credits": 4,
        "level": "300",
        "capacity": 40,
    },
    {
        "code": "MOB302",
        "title": "Mobile App Development with Flutter & Dart (ការអភិវឌ្ឍកម្មវិធី Flutter)",
        "description": "Cross-platform mobile applications for Android and iOS using Flutter SDK, state management with Riverpod, and REST API consumption.",
        "credits": 4,
        "level": "300",
        "capacity": 35,
    },
    {
        "code": "DB303",
        "title": "Advanced Database: PostgreSQL & NoSQL MongoDB (ប្រព័ន្ធទិន្នន័យកម្រិតខ្ពស់)",
        "description": "Enterprise PostgreSQL database tuning, stored procedures, triggers, JSONB documents, and MongoDB document clustering.",
        "credits": 3,
        "level": "300",
        "capacity": 35,
    },
    {
        "code": "SEC304",
        "title": "Cyber Security Fundamentals & Ethical Hacking (សន្តិសុខព័ត៌មាន Cyber Security)",
        "description": "Network penetration testing, vulnerability assessment, cryptography, OWASP Top 10 vulnerabilities, and defense strategies.",
        "credits": 3,
        "level": "300",
        "capacity": 35,
    },
    {
        "code": "SE305",
        "title": "Software Engineering & Agile Methodologies (វិស្វកម្មផ្នែកទន់ និង Agile)",
        "description": "Software development life cycle, Scrum/Kanban frameworks, UML modeling, Git version control workflows, and CI/CD pipelines.",
        "credits": 3,
        "level": "300",
        "capacity": 40,
    },
    {
        "code": "CLOUD306",
        "title": "Cloud Computing: AWS Architecture & Docker (បច្ចេកវិទ្យា Cloud & Docker)",
        "description": "Cloud virtualization, Amazon EC2, S3 storage, Docker containerization, microservices deployment, and serverless compute.",
        "credits": 4,
        "level": "300",
        "capacity": 35,
    },

    # 400-Level Specialization & Capstone Courses
    {
        "code": "AI401",
        "title": "Artificial Intelligence & Machine Learning (បញ្ញាសិប្បនិម្មិត AI & Machine Learning)",
        "description": "Supervised and unsupervised learning, regression, classification, neural networks, scikit-learn, and computer vision with OpenCV.",
        "credits": 4,
        "level": "400",
        "capacity": 30,
    },
    {
        "code": "DS402",
        "title": "Data Science & Big Data Analytics (វិទ្យាសាស្ត្រទិន្នន័យ Data Science)",
        "description": "Data wrangling with Pandas/NumPy, exploratory data visualization with Matplotlib/Seaborn, and predictive statistical analytics.",
        "credits": 4,
        "level": "400",
        "capacity": 30,
    },
    {
        "code": "NET403",
        "title": "Enterprise Network Security & Firewalls (សន្តិសុខបណ្តាញកម្រិតខ្ពស់)",
        "description": "Next-generation firewalls, VPN tunnels, intrusion detection/prevention systems (IDS/IPS), and enterprise network monitoring.",
        "credits": 3,
        "level": "400",
        "capacity": 30,
    },
    {
        "code": "IOT404",
        "title": "Internet of Things (IoT) & Smart Devices (ប្រព័ន្ធ IoT និងឧបករណ៍ឆ្លាតវៃ)",
        "description": "Sensor interfacing with Raspberry Pi and ESP32, MQTT protocols, cloud IoT telemetry dashboards, and smart home automation.",
        "credits": 3,
        "level": "400",
        "capacity": 30,
    },
    {
        "code": "MOB405",
        "title": "Advanced Mobile Engineering: iOS Swift & Kotlin (កម្មវិធីទូរស័ព្ទកម្រិតខ្ពស់)",
        "description": "Native mobile development paradigms, memory management, background services, push notifications, and app store deployment.",
        "credits": 3,
        "level": "400",
        "capacity": 30,
    },
    {
        "code": "PM406",
        "title": "IT Project Management & Professional Ethics (ការគ្រប់គ្រងគម្រោង IT)",
        "description": "Project charter creation, cost estimation, risk matrices, stakeholder management, Cambodian intellectual property laws, and professional IT ethics.",
        "credits": 3,
        "level": "400",
        "capacity": 45,
    },
    {
        "code": "QA407",
        "title": "Software Quality Assurance & Automated Testing (ការធានាគុណភាពផ្នែកទន់)",
        "description": "Unit testing, integration testing, end-to-end automation with Selenium/Playwright, test-driven development (TDD), and performance load testing.",
        "credits": 3,
        "level": "400",
        "capacity": 35,
    },
    {
        "code": "UI408",
        "title": "UI/UX Design Systems & Human-Computer Interaction (ការរចនា UI/UX)",
        "description": "User research, wireframing, high-fidelity interactive prototyping in Figma, accessibility standards (WCAG), and usability testing.",
        "credits": 3,
        "level": "400",
        "capacity": 35,
    },
    {
        "code": "CAP409",
        "title": "IT Capstone Graduation Project (គម្រោងបញ្ចប់ការសិក្សាផ្នែកព័ត៌មានវិទ្យា)",
        "description": "Final graduation capstone project where student teams plan, architect, develop, and present a complete production software solution.",
        "credits": 4,
        "level": "400",
        "capacity": 50,
    },
]

KHMER_NOTES = [
    "លទ្ធផលសិក្សាល្អប្រសើរណាស់ (Outstanding academic performance)",
    "ការចូលរៀនទៀងទាត់ និងសកម្មក្នុងថ្នាក់ (Regular attendance and active in class)",
    "ការប្រឡងបញ្ចប់វគ្គទទួលបានពិន្ទុខ្ពស់ (High score on final examination)",
    "កិច្ចការស្រាវជ្រាវធ្វើបានល្អណាស់ (Very well-researched project assignment)",
    "មានការយល់ដឹងខ្ពស់លើការសរសេរកូដ (Strong grasp of programming concepts)",
    "សិស្សឆ្លាត និងមានភាពច្នៃប្រឌិត (Smart student with great creativity)",
    "ខិតខំប្រឹងប្រែងរៀនសូត្របានល្អ (Good effort and consistent study habit)",
    "ការងារក្រុមសហការបានល្អ (Great teamwork and peer collaboration)",
    "ត្រូវការអនុវត្តបន្ថែមលើលំហាត់កូដ (Needs additional coding practice)",
    "ការចូលរួមមធ្យម គួរព្យាយាមបន្ថែម (Average attendance, can improve more)",
]

def generate_cambodian_phone():
    prefix = random.choice(PHONE_PREFIXES)
    number = random.randint(100000, 999999)
    return f"{prefix}{number}"

def run_seed(num_students=1000):
    print("=" * 65)
    print("🚀 Build Bright University (BBU) - Seeding Khmer IT Data")
    print(f"🎯 Target: {num_students} Students, 25 IT Courses, 2,500+ Enrollments")
    print("=" * 65)

    with transaction.atomic():
        # 1. Create Instructors & Role Test Accounts
        print("\n[1/4] 👨‍🏫 Creating IT Faculty Instructors & Demo Accounts...")
        instructor_objs = []
        default_pw_hash = make_password("BbuFaculty@2026")
        
        # Ensure 'admin' Superuser Account
        admin_user, _ = User.objects.get_or_create(
            username="admin",
            defaults={
                "first_name": "System",
                "last_name": "Administrator",
                "email": "admin@bbu.edu.kh",
                "is_staff": True,
                "is_superuser": True,
            }
        )
        admin_user.set_password("admin123456")
        admin_user.is_staff = True
        admin_user.is_superuser = True
        admin_user.save()

        # Ensure 'teacher' Faculty Account
        teacher_user, _ = User.objects.get_or_create(
            username="teacher",
            defaults={
                "first_name": "Vichea (វិជ្ជា)",
                "last_name": "Heng (ហេង)",
                "email": "teacher@bbu.edu.kh",
                "is_staff": True,
                "is_superuser": False,
            }
        )
        teacher_user.set_password("teacher123456")
        teacher_user.is_staff = True
        teacher_user.is_superuser = False
        teacher_user.save()
        instructor_objs.append(teacher_user)

        # Ensure 'student' Demo Account
        student_user, _ = User.objects.get_or_create(
            username="student",
            defaults={
                "first_name": "Dara",
                "last_name": "Sok",
                "email": "student@bbu.edu.kh",
                "is_staff": False,
                "is_superuser": False,
            }
        )
        student_user.set_password("student123456")
        student_user.is_staff = False
        student_user.is_superuser = False
        student_user.save()

        Student.objects.update_or_create(
            user=student_user,
            defaults={
                "student_id": "STU-BBU-001",
                "khmer_name": "សុខ ដារ៉ា",
                "date_of_birth": date(2003, 5, 15),
                "gender": "M",
                "phone_number": "012888999",
                "address": "Street 271, Sangkat Boeung Tumpun",
                "city": "Phnom Penh (ភ្នំពេញ)",
                "country": "Cambodia (កម្ពុជា)",
                "is_active": True,
            }
        )

        for username, first_name, last_name, email in INSTRUCTORS_DATA:
            user, created = User.objects.get_or_create(
                username=username,
                defaults={
                    "first_name": first_name,
                    "last_name": last_name,
                    "email": email,
                    "password": default_pw_hash,
                    "is_staff": True,
                }
            )
            instructor_objs.append(user)
        print(f"      ✅ {len(instructor_objs)} Instructors ready (including 'teacher').")

        # 2. Create Courses
        print("\n[2/4] 📚 Creating BBU IT Courses...")
        course_objs = []
        base_start = date(2024, 1, 15)
        base_end = date(2024, 6, 15)

        for i, c_data in enumerate(IT_COURSES_DATA):
            instructor = instructor_objs[i % len(instructor_objs)]
            course, created = Course.objects.update_or_create(
                code=c_data["code"],
                defaults={
                    "title": c_data["title"],
                    "description": c_data["description"],
                    "instructor": instructor,
                    "credits": c_data["credits"],
                    "level": c_data["level"],
                    "capacity": c_data["capacity"],
                    "status": "ACTIVE",
                    "start_date": base_start,
                    "end_date": base_end,
                }
            )
            course_objs.append(course)
        print(f"      ✅ {len(course_objs)} IT Courses configured.")

        # 3. Create Students (Batch Generation)
        print(f"\n[3/4] 🎓 Generating {num_students} Khmer Student Records...")
        
        # Determine existing student count for unique IDs
        existing_students = set(Student.objects.values_list('student_id', flat=True))
        existing_usernames = set(User.objects.values_list('username', flat=True))
        
        student_pw_hash = make_password("Student@123456")
        
        new_users = []
        user_meta = [] # Store student metadata associated with user
        
        id_counter = 1
        current_year = 2024
        
        for _ in range(num_students):
            # Generate unique student ID (e.g. BBU-2024-0001)
            while True:
                student_id = f"BBU-{current_year}-{id_counter:04d}"
                id_counter += 1
                if student_id not in existing_students:
                    existing_students.add(student_id)
                    break

            # Gender selection
            gender_roll = random.random()
            if gender_roll < 0.49:
                gender = "M"
                first_name_en, first_name_kh = random.choice(KHMER_MALE_FIRST_NAMES)
            elif gender_roll < 0.98:
                gender = "F"
                first_name_en, first_name_kh = random.choice(KHMER_FEMALE_FIRST_NAMES)
            else:
                gender = "O"
                first_name_en, first_name_kh = random.choice(KHMER_MALE_FIRST_NAMES)

            last_name_en, last_name_kh = random.choice(KHMER_LAST_NAMES)
            
            # Primary Khmer name (Last Name First Name in Khmer tradition)
            khmer_name = f"{last_name_kh} {first_name_kh}"
            first_name = first_name_en
            last_name = last_name_en

            # Unique username
            clean_first = first_name_en.lower()
            clean_last = last_name_en.lower()
            username = f"{clean_last}_{clean_first}_{id_counter}"
            while username in existing_usernames:
                username = f"{clean_last}_{clean_first}_{random.randint(1000, 99999)}"
            existing_usernames.add(username)

            email = f"{clean_last}.{clean_first}{id_counter}@student.bbu.edu.kh"

            # Birth date (18 - 25 years old)
            dob_year = random.randint(1999, 2005)
            dob_month = random.randint(1, 12)
            dob_day = random.randint(1, 28)
            dob = date(dob_year, dob_month, dob_day)

            # Location
            city_en, city_kh = random.choice(CAMBODIAN_CITIES)
            city = f"{city_en} ({city_kh})"
            address = f"{random.randint(1, 450)}, {random.choice(KHMER_STREET_ADDRESSES)}"
            phone = generate_cambodian_phone()
            
            # User object
            user = User(
                username=username,
                first_name=first_name,
                last_name=last_name,
                email=email,
                password=student_pw_hash,
                is_active=True,
            )
            new_users.append(user)
            user_meta.append({
                "student_id": student_id,
                "khmer_name": khmer_name,
                "date_of_birth": dob,
                "gender": gender,
                "phone_number": phone,
                "address": address,
                "city": city,
                "country": "Cambodia (កម្ពុជា)",
                "is_active": random.random() > 0.04, # 96% active
            })

        print("      📦 Bulk saving User accounts...")
        User.objects.bulk_create(new_users, batch_size=500)

        # Retrieve created users to get their DB primary keys
        created_usernames = [u.username for u in new_users]
        user_map = {u.username: u for u in User.objects.filter(username__in=created_usernames)}

        # Prepare Student objects
        student_objs = []
        for user_item, meta in zip(new_users, user_meta):
            user_inst = user_map[user_item.username]
            student = Student(
                user=user_inst,
                student_id=meta["student_id"],
                khmer_name=meta["khmer_name"],
                date_of_birth=meta["date_of_birth"],
                gender=meta["gender"],
                phone_number=meta["phone_number"],
                address=meta["address"],
                city=meta["city"],
                country=meta["country"],
                gpa=Decimal("0.00"),
                is_active=meta["is_active"],
            )
            student_objs.append(student)

        print("      📦 Bulk saving Student profiles...")
        Student.objects.bulk_create(student_objs, batch_size=500)
        
        # Retrieve saved students
        saved_students = list(Student.objects.filter(student_id__in=[s.student_id for s in student_objs]))
        print(f"      ✅ {len(saved_students)} Students successfully created.")

        # 4. Assign Course Enrollments
        print("\n[4/4] 📝 Assigning Course Enrollments & Computing Grades...")
        enrollment_objs = []
        student_gpa_map = {s.id: [] for s in saved_students}

        for student in saved_students:
            # Each student takes 2 to 4 courses randomly
            num_courses = random.randint(2, 4)
            chosen_courses = random.sample(course_objs, num_courses)

            for course in chosen_courses:
                status_roll = random.random()
                
                if status_roll < 0.70:
                    # 70% Completed with scores & calculated grades
                    status = "COMPLETED"
                    # Realistic grade distribution centered around 75-85
                    score = round(Decimal(str(random.gauss(80, 11))), 2)
                    score = max(Decimal("52.00"), min(Decimal("99.50"), score))
                    
                    if score >= 90:
                        grade = "A"
                    elif score >= 80:
                        grade = "B"
                    elif score >= 70:
                        grade = "C"
                    elif score >= 60:
                        grade = "D"
                    else:
                        grade = "F"
                        
                    attendance = round(Decimal(str(random.uniform(80.0, 100.0))), 1)
                    completed_date = course.end_date
                    notes = random.choice(KHMER_NOTES)
                    
                    # Store 4.0 scale points for GPA
                    grade_points = {"A": 4.0, "B": 3.0, "C": 2.0, "D": 1.0, "F": 0.0}[grade]
                    student_gpa_map[student.id].append(grade_points)

                elif status_roll < 0.92:
                    # 22% Currently Enrolled
                    status = "ENROLLED"
                    score = None
                    grade = None
                    attendance = round(Decimal(str(random.uniform(85.0, 100.0))), 1)
                    completed_date = None
                    notes = "កំពុងសិក្សា (Currently in progress)"

                elif status_roll < 0.97:
                    # 5% Dropped
                    status = "DROPPED"
                    score = None
                    grade = None
                    attendance = round(Decimal(str(random.uniform(40.0, 70.0))), 1)
                    completed_date = None
                    notes = "សុំឈប់ដោយសារមូលហេតុផ្ទាល់ខ្លួន (Dropped due to personal reasons)"

                else:
                    # 3% Suspended
                    status = "SUSPENDED"
                    score = None
                    grade = None
                    attendance = round(Decimal(str(random.uniform(30.0, 60.0))), 1)
                    completed_date = None
                    notes = "ព្យួរការសិក្សាបណ្តោះអាសន្ន (Study temporarily suspended)"

                enrollment = Enrollment(
                    student=student,
                    course=course,
                    status=status,
                    score=score,
                    grade=grade,
                    attendance_percentage=attendance,
                    completed_date=completed_date,
                    notes=notes,
                )
                enrollment_objs.append(enrollment)

        print(f"      📦 Bulk saving {len(enrollment_objs)} Enrollments...")
        Enrollment.objects.bulk_create(enrollment_objs, batch_size=1000)
        print(f"      ✅ {len(enrollment_objs)} Enrollments created.")

        # Update student GPAs based on completed courses
        print("\n📊 Updating Student GPAs...")
        students_to_update = []
        for student in saved_students:
            points = student_gpa_map.get(student.id, [])
            if points:
                calc_gpa = round(sum(points) / len(points), 2)
            else:
                calc_gpa = Decimal("0.00")
            student.gpa = Decimal(str(calc_gpa))
            students_to_update.append(student)

        Student.objects.bulk_update(students_to_update, ['gpa'], batch_size=500)
        print(f"      ✅ {len(students_to_update)} Student GPAs computed and saved.")

    print("\n" + "=" * 65)
    print("🎉 DATA SEEDING COMPLETE!")
    print(f"👥 Total Students in System:    {Student.objects.count():,}")
    print(f"📚 Total IT Courses in System: {Course.objects.count():,}")
    print(f"📝 Total Enrollments in System:{Enrollment.objects.count():,}")
    print(f"👑 Admin Superuser Account:     admin   / admin123456")
    print(f"👨‍🏫 Faculty Teacher Account:     teacher / teacher123456")
    print(f"🎓 Regular Student Account:     student / student123456")
    print("=" * 65)

if __name__ == '__main__':
    count = 1000
    if len(sys.argv) > 1:
        try:
            count = int(sys.argv[1])
        except ValueError:
            pass
    run_seed(count)

```

# ឬដំណើរការ Script ផ្ទាល់
python scripts/generate_khmer_data.py
```

### ១២.២ ដំណើរការ Unit Tests
ធានាថាប្រព័ន្ធទាំងមូលដំណើរការគ្មានកំហុស (30 Unit Tests Pass):

```bash
python manage.py test
```

### ១២.៣ ដំណើរការ Development Server
```bash
python manage.py runserver 127.0.0.1:8000
```
- **Web App**: `http://127.0.0.1:8000/`
- **Admin Panel**: `http://127.0.0.1:8000/admin/`
- **REST API**: `http://127.0.0.1:8000/api/`

### ១២.៤ ការគ្រប់គ្រង Git និងការដាក់ឱ្យដំណើរការលើ Cloud (Render & Heroku)
ដើម្បីរៀនពីរបៀប Push កូដឡើង GitHub និង Deploy ទៅកាន់ Cloud (Render ឬ Heroku) ដោយប្រើ PostgreSQL Database និង WhiteNoise សូមអានមគ្គុទ្ទេសក៍ពេញលេញ៖
👉 [មគ្គុទ្ទេសក៍ការគ្រប់គ្រង Git/GitHub និងការដាក់ឱ្យដំណើរការលើ Cloud (Render & Heroku)](file:///Users/thavrakchan/Nextcloud/Work/BBU/Subject/Python/Python%20Project/Lessons_P24/django_lesson/lessons/GIT_AND_DEPLOYMENT_GUIDE_KH.md)

---

## 🌟 សេចក្តីសន្និដ្ឋាន (Conclusion)
តាមរយៈការអនុវត្តតាមជំហានទាំង ១២ នេះ និស្សិតទទួលបានបទពិសោធន៍បង្កើតប្រព័ន្ធគ្រប់គ្រងនិស្សិត **Django Full-Stack** ពិតប្រាកដមួយដែលមានលក្ខណៈសម្បត្តិស្តង់ដារឧស្សាហកម្ម រួមមាន **Database Modeling**, **Validation Forms**, **Custom Views**, **Modern Templates**, **Media Upload**, **REST API**, និង **Automated Testing**!
